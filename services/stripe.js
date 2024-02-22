const validator = require('../helpers/validator');
var multer_helper = require('../helpers/multer');
const send_email = require('../helpers/sendEmail');
const axios =  require('axios');
var jwt = require("jsonwebtoken")
const bcrypt = require('bcryptjs')
const db = require('./db');
const path = require('path')
const moment = require('moment')
const { OAuth2Client } = require("google-auth-library");
const GOOGLE_CLIENT_ID = process.env.GOOGLE_CLIENT_ID;
const client = new OAuth2Client(GOOGLE_CLIENT_ID);
require('dotenv').config();
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
var cron = require('node-cron');
// cron.schedule('* * * * *', () => {
//   console.log('running a task every minute');
// })
async function payment(req, res) {
  try{
    var response = {}
    response.success = false
    
    const validationRule = {
        "property_id": "required",
        "booking_id": "required",
        "user_id": "required",
        "currency":"required"
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        return response
    }
    if(response.err){
        return response
    }
    }).catch( err => console.log(err))
    if(req.body.customer_id == '' || req.body.customer_id == null || req.body.customer_id == undefined || !req.body.customer_id){
        var customer = await stripe.customers.create({
            email: req.body.email,
          });
        const update_user = await db.executeQuery(`update users set customer_id = '${customer.id}' where id=${req.body.user_id}`)
    
    }
    
    const session = await stripe.checkout.sessions.create({
      payment_method_types: ["card"],
      line_items :  [{
        price_data: {
          currency: req.body.currency ? req.body.currency : 'usd',
          product_data: {
            name: req.body.property_name ? req.body.property_name : 'Test',
            description: 'Booking payment for' + req.body.property_name ?req.body.property_name : 'Test',
            images:['public/data/property/20230103_153833.jpg']
          },
          unit_amount: req.body.price ? req.body.price * 100 : 0 * 100,
          
        },
        quantity: 1,
      }],
      metadata: {
        property_id:req.body.property_id,
        booking_id:req.body.booking_id,
        user_id:req.body.user_id
      },
      mode: "payment",
      customer: req.body.customer_id ? req.body.customer_id : customer.id,
      success_url: `${process.env.CLIENT_URL}/`,
      cancel_url: `${process.env.CLIENT_URL}/cart`,
      
    });
    return {
        url:session.url,
        success:true
    }
  }
  catch(err){
    console.log(err,'error in payement session creation')
    return res.status(500).json({success:false, mssage:'Something went wrong'})
  }
}
async function updatePaymentStatus(req,res){
          let data;
          let eventType;
          // Check if webhook signing is configured.
          let webhookSecret;
          webhookSecret = process.env.STRIPE_WEBHOOK_KEY;
      
          if (webhookSecret) {
            // Retrieve the event by verifying the signature using the raw body and secret.
            let event;
            let signature = req.headers["stripe-signature"];
            try {
              event = stripe.webhooks.constructEvent(
                req.body,
                signature,
                webhookSecret
              );
            } catch (err) {
              console.log(`⚠️  Webhook signature verification failed:  ${err}`);
              return res.sendStatus(400);
            }
            data = event.data.object;
            eventType = event.type;
          } else {
            data = req.body.data.object;
            eventType = req.body.type;
          }
          console.log(eventType,'eventType')
        //   console.log(data,'data   ')
          if (eventType === "checkout.session.completed" || eventType === "charge.succeeded") {
            stripe.customers
              .retrieve(data.customer,{
                apiKey: process.env.STRIPE_SECRET_KEY
              })
              .then(async (customer) => {
                try {
                  // CREATE ORDER
                  createOrder(customer, data,eventType);
                  console.log('dfdf')
                } catch (err) {
                  console.log(typeof createOrder);
                  console.log(err);
                }
              })
              .catch((err) => console.log(err.message));
          }
          res.status(200).end();
}
const createOrder = async (customer, data,eventType) => {
    if(eventType == 'checkout.session.completed'){
        console.log(data,'session success')
        const unixTimestamp = data.created;
        const timestampInMilliseconds = unixTimestamp * 1000; // Convert seconds to milliseconds

        const formattedTimestamp = new Date(timestampInMilliseconds).toISOString().slice(0, 19).replace('T', ' ');

        console.log(formattedTimestamp,'create')
        var new_order = `update orders set customer_id='${data.customer}',user_id='${data.metadata.user_id}',property_id='${data.metadata.property_id}',booking_id='${data.metadata.booking_id}',order_date='${formattedTimestamp}',total_amount='${data.amount_total}',currency='${data.currency}',status='${data.payment_status}' where payment_intent_id='${data.payment_intent}'`
        
        var update_property_booking = `update property_booking set stripe_session_id = '${data.id}',payment_status = ${data.payment_status == 'paid' ? 1:0} where id=${data.metadata.booking_id}`
        
    
        try {
            await db.executeQuery(new_order)
            const is_updated = await db.executeQuery(update_property_booking)
        console.log("Processed Order:");
        } catch (err) {
        console.log(err);
        }
    }
    if(eventType == 'charge.succeeded'){
        console.log(data,'charge success')
        var update_property_booking = `insert into orders (transaction_id,payment_intent_id) VALUES ('${data.id}','${data.payment_intent}')`
        try {
            const status= await db.executeQuery(update_property_booking)
        } catch (err) {
            console.log(err,errrorrrr);
        }

    }
    
  };

async function refund(req,res){
    const booking_id = req.body.booking_id
    const charge_id = req.body.charge_id
    try{
        const refund = await stripe.refunds.create({
            charge: charge_id ? charge_id : 'ch_3O6hRiBpiNZubiGJ0ecakhjq',
            amount:req.body.amount ? req.body.amount : 1,
            reason: req.body.reason ? req.body.reason : 'requested_by_customer',
            metadata: {
                booking_id:req.body.booking_id,
                user_id:req.body.user_id
            }
          });
        if(refund.status == 'succeeded'){
          const unixTimestamp = refund.created;
          const timestampInMilliseconds = unixTimestamp * 1000;
            var property_booking = await db.executeQuery(`update property_booking set payment_status='refunded',is_cancelled = 1 where id=${booking_id}`)
            var stripe_refund = await db.executeQuery(`insert into stripe_refunds (charge_id,amount,currency,reason,created_at,status) VALUES ('${refund.id}','${refund.amount}','${refund.currency}','${refund.reason}','${timestampInMilliseconds}','${refund.status}')`)
        }
        if (!property_booking.errno || !stripe_refund.errno){
            return {
                success: true,
                message:'Refund created successfully'
            }
        }
        return {
          success:false,
          message: 'Something went wrong.'
        }
    }
    catch(err){
        console.log(err)
        if (err.type == 'id'){
          return{
            success:false,
            param:'refund',
            message:'No refund or order found'
          }
        }
        return {
            success: false,
            param: err.param,
            message:err.message
        }
    }
    
}
module.exports = {
    payment,
    updatePaymentStatus,
    refund
}

