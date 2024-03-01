const validator = require('../helpers/validator');
var multer_helper = require('../helpers/multer');
const send_email = require('../helpers/sendEmail');
var jwt = require("jsonwebtoken")
const bcrypt = require('bcryptjs')
const db = require('./db');
const path = require('path');
const moment = require('moment');
require('dotenv').config();
var countriesList = require("countries-list");
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY)
async function listProperties(req){
    
    var response = {}
    response.success = false
    console.log(req.body)
    const skip = req?.body?.skip
    const top = req?.body?.top
    const location = req.body.location ? req.body.location : null
    const type = req.body.type ? req.body.type : null
    const bedrooms = req.body.bedrooms ? req.body.bedrooms: null
    const bathrooms = req.body.bathrooms ? req.body.bathrooms : null 
    const wifi = req.body.wifi ? req.body.wifi : null
    const pool = req.body.pool ? req.body.pool : null
    const price_max = req.body.price_max ? req.body.price_max : null
    const price_min = req.body.price_min ? req.body.price_min : null
    const pets = req.body.pets ? req.body.pets : null
    const tags = req.body.tags ? req.body.tags : null
    const continent = req.body.continent ? req.body.continent : null
    const tyoe = req.body.type ? req.body.type : null
    var append_filters = `where 1=1 and is_active=1 and is_pending = 0 and is_approved = 1`
    if (continent){
        append_filters += ` and (continent like '%${continent}%' or location like '%${continent}%')`
    }
    if (location){
        append_filters += ` and location like '%${location}%'`
    }
    if (type){
        append_filters += ` and type = '${type}'`
    }
    if (bedrooms){
        append_filters += ` and bedrooms = '${bedrooms}'`
    }
    if (bathrooms){
        append_filters += ` and bathrooms = '${bathrooms}'`
    }
    if (wifi){
        append_filters += ` and wifi = '${wifi}'`
    }
    if (pool){
        append_filters += ` and pool = '${pool}'`
    }
    if (price_max && price_min){
        append_filters += ` and night_rate between ${price_min} and ${price_max} `
    }
    if (price_max){
        append_filters += ` and night_rate <= ${price_max} `
    }
    if (price_min){
        append_filters += ` and night_rate >= ${price_min} `
    }
    if (pets){
        append_filters += ` and pets = ${pets} `
    }
    if (tags){
        append_filters += ` and tags like '%${tags}%' `
    }
    var list_property_query = `select * from properties  ${append_filters} LIMIT ? OFFSET ?;`
    var list_property_params = [top,skip]
    var results = await db.executeQuery(list_property_query,list_property_params)
    console.log(list_property_query)

    response.success = true
    response.data = results
    response.total_count = await db.executeQuery(`select count(id) as total from properties ${append_filters}`,'')
    return response
}
async function listUserProperties(req){
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const user_id = [decodedToken.payload.user_id]
    var response = {}
    response.success = false
    console.log(req.body)
    const skip = req?.body?.skip
    const top = req?.body?.top
    const location = req.body.location ? req.body.location : null
    const type = req.body.type ? req.body.type : null
    const bedrooms = req.body.bedrooms ? req.body.bedrooms: null
    const bathrooms = req.body.bathrooms ? req.body.bathrooms : null 
    const wifi = req.body.wifi ? req.body.wifi : null
    const pool = req.body.pool ? req.body.pool : null
    const price_max = req.body.price_max ? req.body.price_max : null
    const price_min = req.body.price_min ? req.body.price_min : null
    const pets = req.body.pets ? req.body.pets : null
    const tags = req.body.tags ? req.body.tags : null
    const continent = req.body.continent ? req.body.continent : null
    var append_filters = `where 1=1 and created_by_user = '${user_id}'`
    if (continent){
        append_filters += ` and (continent like '%${continent}%' or location like '%${continent}%')`
    }
    if (location){
        append_filters += ` and location like '%${location}%'`
    }
    if (type){
        append_filters += ` and type like '%${type}%'`
    }
    if (bedrooms){
        append_filters += ` and bedrooms = '${bedrooms}'`
    }
    if (bathrooms){
        append_filters += ` and bathrooms = '${bathrooms}'`
    }
    if (wifi){
        append_filters += ` and wifi = '${wifi}'`
    }
    if (pool){
        append_filters += ` and pool = '${wifi}'`
    }
    if (price_max && price_min){
        append_filters += ` and night_rate between ${price_min} and ${price_max} `
    }
    if (price_max){
        append_filters += ` and night_rate <= ${price_max} `
    }
    if (price_min){
        append_filters += ` and night_rate >= ${price_min} `
    }
    if (pets){
        append_filters += ` and pets = ${pets} `
    }
    if (tags){
        append_filters += ` and tags like '%${tags}%' `
    }
    if (type){
        append_filters += ` and type like '%${type}%' `
    }
    var list_property_query = `select * from properties  ${append_filters} LIMIT ? OFFSET ?;`
    var list_property_params = [top,skip]
    var results = await db.executeQuery(list_property_query,list_property_params)
    console.log(list_property_query)

    response.success = true
    response.data = results
    response.total_count = await db.executeQuery(`select count(id) as total from properties ${append_filters}`,'')
    return response
}

async function listBookedProperties(req){
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const user_id = [decodedToken.payload.user_id]
    var response = {}
    response.success = false
    console.log(req.body)
    const skip = req?.body?.skip
    const top = req?.body?.top
    const location = req.body.location ? req.body.location : null
    const type = req.body.type ? req.body.type : null
    const bedrooms = req.body.bedrooms ? req.body.bedrooms: null
    const bathrooms = req.body.bathrooms ? req.body.bathrooms : null 
    const wifi = req.body.wifi ? req.body.wifi : null
    const pool = req.body.pool ? req.body.pool : null
    const price_max = req.body.price_max ? req.body.price_max : null
    const price_min = req.body.price_min ? req.body.price_min : null
    const pets = req.body.pets ? req.body.pets : null
    const tags = req.body.tags ? req.body.tags : null
    const continent = req.body.continent ? req.body.continent : null
    const tyoe = req.body.type ? req.body.type : null
    var append_filters = `where 1=1 `
    if (continent){
        append_filters += ` and (continent like '%${continent}%' or location like '%${continent}%')`
    }
    if (location){
        append_filters += ` and location like '%${location}%'`
    }
    if (type){
        append_filters += ` and type like '%${type}%'`
    }
    if (bedrooms){
        append_filters += ` and bedrooms = '%${bedrooms}%'`
    }
    if (bathrooms){
        append_filters += ` and bathrooms = '%${bathrooms}%'`
    }
    if (wifi){
        append_filters += ` and wifi = '%${wifi}%'`
    }
    if (pool){
        append_filters += ` and pool = '%${wifi}%'`
    }
    if (price_max && price_min){
        append_filters += ` and price between ${price_min} and ${price_max} `
    }
    if (pets){
        append_filters += ` and pets = ${pets} `
    }
    if (tags){
        append_filters += ` and tags like '%${tags}%' `
    }
    if (type){
        append_filters += ` and type like '%${type}%' `
    }
    var list_property_query = `select * from properties left join property_booking on properties.id=property_booking.property_id  ${append_filters} and property_booking.booked_by_user_id = ${user_id}  LIMIT ? OFFSET ?;`
    var list_property_params = [top,skip]
    var results = await db.executeQuery(list_property_query,list_property_params)
    console.log(list_property_query)

    response.success = true
    response.data = results
    response.total_count = await db.executeQuery(`select count(property_booking.id) as total from properties left join property_booking on properties.id=property_booking.property_id ${append_filters}  and property_booking.booked_by_user_id = ${user_id}`,'')
    return response
}
async function viewProperty(req){
    var response = {}
    response.success = false
    console.log(req.body)
    const property_id = req?.body?.property_id
    var view_property_query = `select users.id as user_id, properties.* from properties join users on properties.created_by_user = users.id where properties.id = ?`
    var property_booked_range = `select property_booking.booked_from_date as booked_from_date,property_booking.booked_to_date as booked_to_date from property_booking left join properties on properties.id=property_booking.property_id where properties.id = ?`
    var view_property_params = [property_id]
    var results = await db.executeQuery(view_property_query,view_property_params)
    var property_booked_range_dates = await db.executeQuery(property_booked_range,view_property_params)
    console.log(property_id)
    var user_property_count = `select count(id) as total_properties from user_properties where user_id = ?`
    var user_languages = `select * from languages where id in (select language_id from user_languages where user_id=?)`
    var user_detail = `select CONCAT(first_name,last_name) as name,profile_pic,created_at,email,phone_number from users where id=?`
    var is_property_count = await db.executeQuery(user_property_count,results[0].user_id)
    var is_user_lang = await db.executeQuery(user_languages,results[0].user_id)
    var is_user_detail = await db.executeQuery(user_detail,results[0].user_id)

    console.log(results)
    response.success = true
    response.results = {}
    response.results.property_detail = results
    response.results.property_dates = property_booked_range_dates
    response.results.owner = {
        owner_languages : is_user_lang,
        owner_property_count : is_property_count[0].total_properties,
        owner_detail : is_user_detail
    }
    return response
}

async function addProperty(req){
    var response = {}
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    console.log(req.body,'add property request')
    const user_id = [decodedToken.payload.user_id]
    const name = req.body.name ? req.body.name : ''
    const location = req.body.location != 'undefined' ? req.body.location : ''
    const longitude = req.body.longitude != 'undefined' ? req.body.longitude : ''
    const latitude = req.body.latitude!= 'undefined' ? req.body.latitude: ''
    const bedrooms = req.body.bedrooms!= 'undefined' ? req.body.bedrooms : 0
    const washrooms = req.body.washrooms != 'undefined' ? req.body.washrooms : 0
    const wifi = req.body.wifi!= 'undefined' ? req.body.wifi : 0
    const check_in = req.body.check_in != 'undefined' ? req.body.check_in : '00:00'
    const check_out = req.body.check_out != 'undefined' ? req.body.check_out : '12:00'
    const created_by_user = user_id
    const night_rate = req.body.night_rate != 'undefined' ? req.body.night_rate : 0 
    const pool = req.body.pool != 'undefined' ? req.body.pool : ''
    const category = req.body.category != 'undefined' ? req.body.category : ''
    const booking_note = req.body.booking_note != 'undefined' ? req.body.booking_note : ''
    const booking_offset = req.body.booking_offset != 'undefined' ? req.body.booking_offset : 1
    const booking_window = req.body.booking_window != 'undefined' || req.body.booking_window != '' ? req.body.booking_window : 1
    const minimum_window_duration = req.body.minimum_window_duration != 'undefined' ? req.body.minimum_window_duration : 1
    const maximum_booking_duration = req.body.maximum_booking_duration != 'undefined' ? req.body.maximum_booking_duration : 30
    const booking_import_url = req.body.booking_import_url != 'undefined' ? req.body.booking_import_url : ''
    const manual = req.body.manual != 'undefined' ? req.body.manual : 0
    const currency = req.body.currency != 'undefined' ? req.body.currency : "usd"
    const country = req.body.country != 'undefined' ? req.body.country : '';
    const pets = req.body.pets != 'undefined' ? req.body.pets : 0;
    const additional = req.body.additional != 'undefined' ? req.body.addtional : '';
    const tags = req.body.tags != 'undefined' ? req.body.tags : '';
    const desc = req.body.desc != 'undefined' ? req.body.desc : '';
    const continent = countriesList.countries[country].continent
    const countinent_full = countriesList.continents[continent]
    const property_doc = req?.files?.property_doc?.filename ? '/property/' + req.files.property_doc.filename : '';
    const phone_number = req?.body?.phone_number != 'undefined' ? req.body.phone_number : ''
    const availibility_from = req?.body?.availibility_from != 'undefined' ? req.body.availibility_from : ''
    const availibility_to = req?.body?.availibility_to != 'undefined' ? req.body.availibility_to : ''
    const cleaning_charges = req?.body?.cleaning_charges != 'undefined' ? req.body.cleaning_charges : ''
    console.log(countinent_full,'dff')
    response.success = false
    console.log(req.body)
    var img_array = ''
    for (var i in req.files){
        for(var j in req.files[i]){
            if(req.files[i][j].fieldname == 'uploadedImages'){
                if (j !=0){
                    img_array += ','+ '/property/' + req.files[i][j].filename
                }
                else{
                    img_array +=  '/property/' + req.files[i][j].filename
                }
            }
            
        }
    }
    console.log(img_array,'img_array')
    const insert_property_query = `insert into properties (name,location,longitude,latitude,bedrooms,washrooms,wifi,check_in,check_out,created_by_user,night_rate,pool,category,property_img,booking_note,booking_offset,booking_window,minimum_booking_duration,maximum_booking_duration,booking_import_url,manual,currency,country,continent,laundary,created_at,modified_at,post_status,type,is_active,city,address,contact,street,zipcode,pets,tags,additional,description,is_pending,is_approved,property_doc,phone_number,availibility_from,availibility_to,cleaning_charges) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
    const insert_property_values = [name,location,longitude,latitude,bedrooms,washrooms,wifi,check_in,check_out,created_by_user,night_rate,pool,category,img_array,booking_note,booking_offset,booking_window,minimum_window_duration,maximum_booking_duration,booking_import_url,manual,currency,country,countinent_full,0,new Date(),new Date(),0,'',1,'','','','','',pets,tags,additional,desc,1,0,property_doc,phone_number,availibility_from,availibility_to,cleaning_charges]
    const property_added = await db.executeQuery(insert_property_query,insert_property_values)
    if(property_added.errno){
        response.success = false
        console.log(property_added.sqlMessage)
        response.message = 'Something went wrong'
        return response
    }
    response.success = true
    response.message = 'Property added successfully.'
    return response
}
async function addFavoriteProperty(req){
    var response = {}
    response.success = false
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const favorite_property_query = `insert into user_properties (property_id,user_id) values (?,?)`
    const favorite_property_values = [req.body.property_id,decodedToken.payload.user_id]
    const favrite_added = await db.executeQuery(favorite_property_query,favorite_property_values)
    if (favrite_added.errno){
        response.message = favrite_added.sqlMessage
        response.success = false
        return response
    }
    response.success = true
    response.message = 'Property has been added to wishlist'
    return response
}
async function removeFavoriteProperty(req){
    var response = {}
    response.success = false
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const favorite_property_query = `delete user_properties where id = ?`
    const favorite_property_values = [req.body.id]
    const favrite_added = await db.executeQuery(favorite_property_query,favorite_property_values)
    if (favrite_added.errno){
        response.message = create_user.sqlMessage
        response.success = false
    }
    response.success = true
    response.message = 'Property has been removed from wishlist'
}
async function listFavoriteProperty(req){
    var response = {}
    response.success = false
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const list_favorite_properties = `select * from properties join user_properties on properties.id = user_properties.property_id where user_id = ?`
    const list_properties_vlaues = [decodedToken.payload.user_id]
    const result_user_properties = await db.executeQuery(list_favorite_properties,list_properties_vlaues)
    response.success = true
    response.results = result_user_properties
    return response
}
async function addPropertyReview(req){
    var response = {}
    response.success = false
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
    });
    const add_review_query = `insert into property_reviews (property_id,user_id,comment,is_active,rating) values (?,?,?,?,?)`
    const add_review_values = [req.body.property_id,decodedToken.payload.user_id,req.body.comment,1,req.body.rating]
    const review_added = await db.executeQuery(add_review_query,add_review_values)
    response.success = true
    response.message = 'Review added successfully.'
    return response
}
async function listPropertyReview(req){
    var response = {}
    response.success = false
    const list_review_query = `select property_reviews.user_id as user_id, property_reviews.property_id as property_id,users.first_name,users.last_name, property_reviews.id as review_id,property_reviews.comment,property_reviews.rating as rating,users.profile_pic as profile_pic from property_reviews join users on property_reviews.user_id = users.id where property_id = ?`
    const list_review_values = [req.body.property_id]
    const property_review = await db.executeQuery(list_review_query,list_review_values)
    response.success = true
    response.results = property_review
    return response
}
async function listServicesLanguages(req){
    var response = {}
    response.success = false
    response.services =  await db.executeQuery('select id,service_name from services','')
    response.languages =  await db.executeQuery('select id,name from languages','')
    return response
}
var enumerateDaysBetweenDates = function(startDate, endDate) {
    var dates = [];

    var currDate = moment(startDate);
    var lastDate = moment(endDate);
    dates.push(currDate.format('YYYY-MM-DD'))
    while(currDate.add(1, 'days').diff(lastDate) <= 0) {
        // console.log(currDate.toDate());
        dates.push(currDate.format('YYYY-MM-DD'));
    }
    dates.push(lastDate.format('YYYY-MM-DD'))
    return dates;
};
async function checkBooking(req){
    var response = {}
    response.success = false
    const validationRule = {
        "property_id": "required|numeric",
        "booked_from_date":"required|string",
        "booked_to_date":"required|string"
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        return response
    }
    }
    )
    const booked_from_date = req.body.booked_from_date
    const booked_to_date = req.body.booked_to_date
    const property_id = req.body.property_id
    var date_range = enumerateDaysBetweenDates(booked_from_date,booked_to_date)
    console.log(date_range,'date')
    
    const property_avail_query = `select * from property_booking where property_id=? and is_booked = 1 and (booked_from_date <= ? AND booked_to_date >= ?)
    OR (booked_from_date >= ? AND booked_from_date <= ?)
    OR (booked_to_date >= ? AND booked_to_date <= ?);`
    const property_avail_detail_query = `select id,date_format(availibility_to,'%Y-%m-%d') as availibility_to,date_format(availibility_from,'%Y-%m-%d') as availibility_from,maximum_booking_duration as maximum_booking_duration,minimum_booking_duration as minimum_booking_duration  from properties where id=?`
    const property_avail_values = [property_id,booked_to_date,booked_from_date,booked_to_date,booked_from_date,booked_to_date,booked_from_date]
    const results = await db.executeQuery(property_avail_query,property_avail_values)
    const is_property_avail_detail_query = await db.executeQuery(property_avail_detail_query,property_id)
    console.log(moment(booked_to_date).diff(moment(booked_from_date).subtract(1,'days'),'days'))
    console.log(booked_from_date , is_property_avail_detail_query[0].availibility_from , booked_to_date , is_property_avail_detail_query[0].availibility_to)
    console.log(moment(booked_from_date).diff(moment(is_property_avail_detail_query[0].availibility_from), 'days'))
    console.log(moment(is_property_avail_detail_query[0].availibility_to).diff(moment(booked_to_date), 'days'))
    console.log(results,'status')
    if(results.length > 0 && results[0].id != undefined){
        response.success = false
        response.message = []
        response.message.push('Property is already reserved. Use other dates.')
        response.is_booked = 1
        response.property_id = results[0].property_id
        response.booked_from_date = results[0].booked_from_date
        response.booked_to_date = results[0].booked_to_date
        response.is_confirmed = results[0].is_confirmed
        response.is_cancelled = results[0].is_cancelled
        return response
    }
    if(results.length == 0){
        response.success = true
        response.is_booked = 0
        // return response
    }
    if(is_property_avail_detail_query[0]?.id != undefined && results.length == 0){
        response.success = true
        response.message = []
        if(moment(booked_to_date).diff(moment(booked_from_date).subtract(1,'days'),'days') > (is_property_avail_detail_query[0].maximum_booking_duration)){
            response.allowed_availibility = 0
            response.message.push(`Your booking days must be maximum ${is_property_avail_detail_query[0].maximum_booking_duration} days`)
        }
        if(moment(booked_to_date).diff(moment(booked_from_date).subtract(1,'days'),'days') < (is_property_avail_detail_query[0].minimum_booking_duration)){
            response.allowed_availibility = 0
            
            response.message.push(`Your booking days must be minimum ${is_property_avail_detail_query[0].minimum_booking_duration} days`)
        }
        if(moment(is_property_avail_detail_query[0].availibility_to).diff(moment(booked_to_date), 'days') < 0){
            response.allowed_availibility = 0
            
            response.message.push(`Booking not available. Check availibilty of property from ${is_property_avail_detail_query[0].availibility_from} to ${is_property_avail_detail_query[0].availibility_to}`)
        }
        if(moment(booked_from_date).diff(moment(is_property_avail_detail_query[0].availibility_from), 'days') < 0){
            response.allowed_availibility = 0
            
            response.message.push(`Booking not available. Check availibilty of property from ${is_property_avail_detail_query[0].availibility_from} to ${is_property_avail_detail_query[0].availibility_to}`)
        }
        if(moment(booked_from_date).diff(moment(is_property_avail_detail_query[0].availibility_from), 'days') < 0 && moment(is_property_avail_detail_query[0].availibility_to).diff(moment(booked_to_date), 'days') < 0){
            response.allowed_availibility = 0
            response.message.push(`Booking not available. Check availibilty of property from ${is_property_avail_detail_query[0].availibility_from} to ${is_property_avail_detail_query[0].availibility_to}`)
        }
        if(response.allowed_availibility == 0){
            response.success = false
            return response
        }
    }
    delete response.message
    return response
}
async function createSubscription(req,res) {
    const token = req.body.tokenID;
    const customer = await stripe.customers.create({
      name: req.body.name,
      email: req.body.email,
      payment_method: req.body.paymentMethod,
      invoice_settings: {
        default_payment_method: req.body.paymentMethod,
      },
    });
  try {
    const charge = await stripe.charges.create({
      amount: req.body.amount,
      currency: req.body.currency,
      source: token,
      metadata:{
        "property_id": "12345",
        "user_id": "67890",
        "booking_id":"1"
    }
    });
    console.log(charge)
    return charge
  } catch (error) {
    console.log(error)
    return error
  }
  }
async function bookProperty(req,res){
    try{
    var response = {}
    response.success = false
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
    });
    const booked_from_date = req.body.booked_from_date
    const booked_to_date = req.body.booked_to_date
    const user_id = decodedToken.payload.user_id
    const property_id = req.body.property_id
    var is_booked_status = 1
    const is_manual = req.body.is_manual ? req.body.is_manual : 0
    if (is_manual == 1){
        is_booked_status = 0
    }
    const validationRule = {
        "property_id": "required|numeric",
        "booked_from_date": "required|string",
        "booked_to_date": "required|string",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        console.log('fdf',response)
        return response
    }
    }
    )
    if(response.err){
        return response
    }
    const get_property_comission = await db.executeQuery(`select comission from hosts_packages left join user_packages on `+
    `user_packages.package_id = hosts_packages.id where user_packages.id = (select created_by_user from properties where id=${property_id}) `)
    
    var host_total = req.body.cleaning_charges + (req.body.quantity * req.body.property_cost)
    if (!get_property_comission || get_property_comission?.[0]?.comission == undefined || get_property_comission?.[0]?.comission == 0 || get_property_comission?.[0]?.comission == '0'){
        var comission = ( 0.125 ) * (host_total)
    }
    else{
        var comission = 0
    }
    var host_service_fee = host_total * (0.02)
    var booker_service_fee = host_total * (0.10)
    var booker_total = host_total + booker_service_fee
    var admin_total = host_service_fee + comission + booker_service_fee
    var host_total_after = host_total - host_service_fee - comission
    const book_property_quer = `insert into property_booking `+
        `(property_id , booked_by_user_id,booked_from_date,` +
        `booked_to_date,is_cancelled,is_confirmed,booked_at,is_booked,is_manual,quantity,service_fee,cleaning_charges,`+
        `property_cost,total_property_cost,commission,host_total,admin_total,host_service_fee,booker_total) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
    const book_property_values = [property_id,user_id,booked_from_date,booked_to_date,0,0,new Date(),
        is_booked_status,is_manual,req.body.quantity,booker_service_fee,req.body.cleaning_charges,
        req.body.property_cost,req.body.total_property_cost,comission,host_total_after,admin_total,host_service_fee,booker_total]
    const is_booked = await db.executeQuery(book_property_quer,book_property_values)
    const hosts_email= `select users.email from properties join users on properties.created_by_user = users.id where properties.id = ?`
    const hosts_email_val = [property_id] 
    const booker_email= `select email from users where id = ?`
    const booker_email_val = [user_id] 
    var is_hosts_email = await db.executeQuery(hosts_email,hosts_email_val)
    var is_booker_email = await db.executeQuery(booker_email,booker_email_val)
    var subject = 'Booking'
    if(!is_booked.errno){
        if (is_hosts_email){
            const email_msg = 'User has created booking for the property.'
            const email_sent = await send_email.sendMail(is_hosts_email[0].email,'',email_msg,subject)
        }
        if (is_booker_email){
            const email_msg = 'Booking has been created successfully. We will contact you soon. Thanks'
            const email_sent = await send_email.sendMail(is_booker_email[0].email,'',email_msg,subject)
        }
        if (process.env.ADMIN_EMAIL){
            const email_msg = 'User has create booking for the property'
            const email_sent = await send_email.sendMail(process.env.ADMIN_EMAIL,'',email_msg,subject)
        }
        response.success = true
        response.message = 'Property booked successfully.'
        response.booking_id = is_booked.insertId
        return response
    }
    return response
    }
    catch(err){
        console.log(err,'error in booking property.')
        res.json(500)
    }
}

async function instantBooking(req){
    var response = {}
    response.success = true
    const booker_phone = req.body.booker_phone
    const booker_email = req.body.booker_email
    const property_id = req.body.property_id
    const property_url = req.body.property_url
    const validationRule = {
        "property_id": "required|numeric",
        "booker_email":"required|email",
        "booker_phone":"required|string"
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        console.log('fdf',response)
        return response
    }
    }
    )
    if(response.err){
        return response
    }
    const hosts_email= `select users.email from properties join users on properties.created_by_user = users.id where properties.id = ?`
    const hosts_email_val = [property_id] 
    var is_hosts_email = await db.executeQuery(hosts_email,hosts_email_val)
    var subject = 'Booking Request'
    if (is_hosts_email){
        response.success = true
        
        const email_msg = `User has created booking for the property. Contact info: Mobile Number ${booker_phone} EMail: ${booker_email}. <a href="http://${process.env.BASE_URL_EMAIL_CLIENT_SIDE}${property_url}">Click here to view property.</a>`
        console.log(email_msg,'email_msg')
        
        const email_sent = await send_email.sendMail(is_hosts_email[0].email,'',email_msg,subject)
    }
    if (booker_email){
        response.success = true
        const email_msg = 'Booking has been created successfully. We will contact you soon. Thanks'
        console.log(email_msg,'email_msg booker')

        const email_sent = await send_email.sendMail(booker_email,'',email_msg,subject)
    }
    if (process.env.ADMIN_EMAIL){
        response.success = true
        const email_msg = `User has request booking for the property. Contact info: Mobile Number ${booker_phone} EMail: ${booker_email}. <a href="http://${process.env.BASE_URL_EMAIL_CLIENT_SIDE}${property_url}">Click here to view property.</a>`
        console.log(email_msg,'email_msg admin')
        
        const email_sent = await send_email.sendMail(process.env.ADMIN_EMAIL,'',email_msg,subject)
    }
    response.message = 'Booking requested successfully.'
    return response
}

async function topRated(req){
    const top_rated_query = `select property_id,properties.*,avg(rating)as rating,(select CONCAT(first_name,' ',last_name)  from users where id=properties.created_by_user) as user_name,(select profile_pic  from users where id=properties.created_by_user) as profile_pic from property_reviews left join properties on properties.id=property_reviews.property_id group by property_id order by rating desc LIMIT 3;`
    const top_rated = await db.executeQuery(top_rated_query,'')
    return top_rated
}
async function detailedListProperties(req){
    const top_rated_query = `select properties.*, (select * from property_booking where property_id=properties.id) as property_bookings  from properties`
    const top_rated = await db.executeQuery(top_rated_query,'')
    return top_rated
}
module.exports = {
    listProperties,
    viewProperty,
    addProperty,
    addFavoriteProperty,
    removeFavoriteProperty,
    listFavoriteProperty,
    listPropertyReview,
    addPropertyReview,
    listServicesLanguages,
    bookProperty,
    checkBooking,
    listUserProperties,
    instantBooking,
    listBookedProperties,
    topRated,
    detailedListProperties,
    createSubscription
}