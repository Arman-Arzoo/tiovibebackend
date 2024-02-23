const validator = require('../helpers/validator');
var multer_helper = require('../helpers/multer');
const send_email = require('../helpers/sendEmail');
var jwt = require("jsonwebtoken")
const bcrypt = require('bcryptjs')
const db = require('./db.js');
const path = require('path');
require('dotenv').config();
var countriesList = require("countries-list");
const { response } = require('../app');
const { count } = require('console');

async function usersList(req){
    const users_list = await db?.executeQuery('select id,username,email,is_active,is_deleted,is_verified,phone_number,is_admin,first_name,last_name,country from users')
    var response = {}
    response.success = true
    response.data = users_list
    return response
}
async function userUpdate(req){
    const user_id = req.body.user_id
    const is_active = req.body.is_active
    var response = {}
    const validationRule = {
        "user_id": "required|numeric",
        "is_active": "required|numeric",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
    })
    if(response.err){
        return response
    }
    const user_update_query = `update users set is_active=? where id=?`
    const user_update_values = [is_active,user_id]
    const is_user_updated = await db?.executeQuery(user_update_query,user_update_values)
    response.success = true
    response.message = 'User has been updated.'
    return response
    
}
async function userDelete(req){
    const user_id = req.body.user_id
    var response = {}
    const validationRule = {
        "user_id": "required|numeric",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
    })
    if(response.err){
        return response
    }
    const user_update_query = `delete from users where id=?`
    const user_update_values = [user_id]
    const is_user_updated = awaitdb?.executeQuery(user_update_query,user_update_values)
    console.log(is_user_updated,'user deleted')
    response.success = true
    response.message = 'User has been deleted.'
    return response
}

async function propertiesList(req){
    var response ={}
    response.success = true
    response.data = results
    const skip = req?.body?.skip
    const top = req?.body?.top
    var list_property_query = `select * from properties where is_active=1 LIMIT ? OFFSET ?;`
    var list_property_params = [top,skip]
    var results = awaitdb?.executeQuery(list_property_query,list_property_params)
    response.total_count = awaitdb?.executeQuery(`select count(id) as total from properties where is_active=1`,'')
    response.data = results
    return response

}
async function updateProperty(req){
    var response = {}
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const property_id = req.body.property_id
    console.log(property_id)
    const validationRule = {
        "property_id": "required|numeric",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
    })
    if(response.err){
        return response
    }
    const user_id = [decodedToken.payload.user_id]
    const name = req.body.name ? req.body.name : ''
    const location = req.body.location ? req.body.location : ''
    const longitude = req.body.longitude ? req.body.longitude : ''
    const latitude = req.body.latitude ? req.body.latitude: ''
    const bedrooms = req.body.bedrooms ? req.body.bedrooms : ''
    const washrooms = req.body.washrooms ? req.body.washrooms : ''
    const wifi = req.body.wifi ? req.body.wifi : ''
    const check_in = req.body.check_in ? req.body.check_in : ''
    const check_out = req.body.check_out ? req.body.check_out : ''
    const created_by_user = user_id
    const night_rate = req.body.night_rate ? req.body.night_rate : '' 
    const pool = req.body.pool ? req.body.pool : ''
    const category = req.body.category ? req.body.category : ''
    const booking_note = req.body.booking_note ? req.body.booking_note : ''
    const booking_offset = req.body.booking_offset ? req.body.booking_offset : 0
    const booking_window = req.body.booking_window ? req.body.booking_window : 0
    const minimum_window_duration = req.body.minimum_window_duration ? req.body.minimum_window_duration : 0
    const maximum_booking_duration = req.body.maximum_booking_duration ? req.body.maximum_booking_duration : 0
    const booking_import_url = req.body.booking_import_url ? req.body.booking_import_url : ''
    const manual = req.body.manual ? req.body.manual : 0
    const currency = req.body.currency ? req.body.currency : 0
    const country = req.body.country ? req.body.country : '';
    const pets = req.body.pets ? req.body.pets : 0;
    const additional = req.body.additional ? req.body.additional : '';
    const tags = req.body.tags ? req.body.tags : '';
    const desc = req.body.desc ? req.body.desc : '';
    const continent = countriesList.countries[country].continent
    const property_doc = req?.files?.property_doc?.filename ? '/property/' + req.files.property_doc.filename : '';
    const phone_number = req?.body?.phone_number ? req.body.phone_number : ''
    const availibility_from = req?.body?.availibility_from ? req.body.availibility_from : ''
    const availibility_to = req?.body?.availibility_to ? req.body.availibility_to : ''
    const cleaning_charges = req?.body?.cleaning_charges ? req.body.cleaning_charges : ''
    console.log(country,'country')
    if(country != undefined || country !='' || country!=null){
        const continent = countriesList.countries[country].continent
        var countinent_full = countriesList.continents[continent]
    }
    else{
        var countinent_full = ''
    }
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
    console.log(img_array,'uploaded images')
    if(req?.body?.uploadedImages){
        var img = req.body.uploadedImages
        for (var i= 0; i < img.length; i++)
        {
            if (img_array){
                img_array += ',' +img[i]
                console.log('comma')
            }
            else
            {
                img_array += img[i]
            }
        }
    }
    console.log(img_array,'img_array')

    const insert_property_query = `update properties set name=?,location=?,longitude=?,latitude=?,bedrooms=?,washrooms=?,wifi=?,check_in=?,check_out=?,night_rate=?,pool=?,category=?,property_img=?,booking_note=?,booking_offset=?,booking_window=?,minimum_booking_duration=?,maximum_booking_duration=?,booking_import_url=?,manual=?,currency=?,country=?,continent=?,laundary=?,modified_at=?,type=?,city=?,address=?,contact=?,street=?,zipcode=?,pets=?,tags=?,additional=?,description=?,property_doc=?,phone_number=?,availibility_from=?,availibility_to=?,cleaning_charges=? where id=?`
    const insert_property_values = [name,location,longitude,latitude,bedrooms,washrooms,wifi,check_in,check_out,night_rate,pool,category,img_array,booking_note,booking_offset,booking_window,minimum_window_duration,maximum_booking_duration,booking_import_url,manual,currency,country,countinent_full,0,new Date(),'','','','','','',pets,tags,additional,desc,property_doc,phone_number,availibility_from,availibility_to,cleaning_charges,property_id]
    console.log(insert_property_query)
    console.log(insert_property_values)
    const property_added = awaitdb?.executeQuery(insert_property_query,insert_property_values)
    if(property_added.errno){
        response.success = false
        console.log(property_added.sqlMessage)
        response.message = 'Something went wrong'
        return response
    }
    response.success = true
    response.message = 'Property updated successfully.'
    return response

}
async function propertiesUpdate(req){
    var response = {}
    response.success = false;
    console.log(req.body)
    const property_id = req.body.property_id
    const is_active = req.body.is_active
    const is_pending = req.body.is_pending
    const is_approved = req.body.is_approved
    const validationRule = {
        "property_id": "required|numeric",
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
    if(response.err){
        return response
    }
    if (is_active != null || is_active != undefined){
        const update_property_query = `update properties set is_active = ? where id = ?`
        const update_property_values = [is_active,property_id]
        var property_updated = awaitdb?.executeQuery(update_property_query,update_property_values)
    }
    if (is_pending != null || is_pending != undefined){
        const update_property_query = `update properties set is_pending = ? where id = ?`
        const update_property_values = [is_pending,property_id]
        var property_updated = awaitdb?.executeQuery(update_property_query,update_property_values)
    }
    if (is_approved !=null || is_approved != undefined){
        const update_property_query = `update properties set is_approved = ? where id = ?`
        const update_property_values = [is_approved,property_id]
        var property_updated = awaitdb?.executeQuery(update_property_query,update_property_values)
    }
    if (property_updated){
        response.success = true
        response.message = 'Property hase been updated.'
        return response
    }
    if(property_updated.errno){
        response.success = false
        response.message = 'Something went wrong.'
        return response
    }
    response.message = 'Property not updated.'
    response.success = true
    return response

}
async function propertiesDelete(req){

}
async function propertyApproval(req){

}
async function transactionsList(req){

}
async function propertyBooking(req){
    var response = {}
    console.log(req.body)
    const skip = req?.body?.skip
    const top = req?.body?.top
    const list_booking_property = 'select properties.*,property_booking.id as property_relation_id,property_booking.*, users.first_name,users.last_name,users.email,users.username from property_booking left join users on booked_by_user_id=users.id left join properties on property_id=properties.id where is_confirmed=0 order by property_booking.id LIMIT ? OFFSET ?;'
    var list_booking_params = [top,skip]
    const list_booking = awaitdb?.executeQuery(list_booking_property,list_booking_params)
    response.total_count = awaitdb?.executeQuery(`select count(id) as total from property_booking where is_confirmed=0`,'')
    response.data = list_booking
    console.log(response)
    return response
}
async function updatePropertyStatus(req){
    var response = {}
    const property_id = req.body.property_id;
    const is_confirmed = req.body.is_confirmed
    const validationRule = {
        "property_id": "required|numeric",
        "is_confirmed": "required|boolean",
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
    const update_property_query= 'update property_booking set is_confirmed=?,is_manual=? where id=?'
    const update_property_value = [is_confirmed,0,property_id]
    const is_updated = awaitdb?.executeQuery(update_property_query,update_property_value)
    if (!is_updated.errno){
        const list_booking_property = 'select property_booking.id as property_id,property_booking.*, users.first_name,users.last_name,users.email,users.username from property_booking left join users on booked_by_user_id=users.id left join properties on property_id=properties.id where property_booking.id=? '
        const list_booking = awaitdb?.executeQuery(list_booking_property,property_id)
        response.success = true
        response.message = 'Property updated successfully.'
        response.data = list_booking
        return response
    }
}
async function bookingStats(req){
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    if(decodedToken.payload.is_admin == 1){
    var booked_properties = `select count(property_booking.id) as confirmed_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where  property_booking.is_confirmed=1`
    const is_confirmed = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select COALESCE(sum(hosts_packages.price),0)  as packages_earning from hosts_packages left join user_packages on hosts_packages.id=user_packages.package_id`
    const packages_earning = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select COALESCE(sum(property_booking.commission),0) + COALESCE(sum(property_booking.service_fee),0)   as earnings, property_booking.property_id as property_id,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where  property_booking.is_confirmed=1 group by property_booking.property_id,properties.name`
    const earnings_by_property = awaitdb?.executeQuery(booked_properties)
    
    var booked_properties = `select COALESCE(sum(property_booking.service_fee),0) + COALESCE(sum(property_booking.commission),0) as total_property_earnings from property_booking where is_confirmed=1`
    const total_property_earnings = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as pending_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where  property_booking.is_confirmed=0 and is_booked=1`
    const is_pending = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as cancelled_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where  property_booking.is_confirmed=0 and is_booked=0 and is_cancelled=1`
    const is_cancelled = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as total_bookings from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id `
    const total_bookings = awaitdb?.executeQuery(booked_properties)
    var total_properties = `select count(id) as total_properties from properties`
    const is_properties = awaitdb?.executeQuery(total_properties)
    var active_properties = `select count(id) as active_properties from properties where is_active=1`
    const is_active_properties = awaitdb?.executeQuery(active_properties)
    var non_active_properties = `select count(id) as non_active_properties from properties where is_active=0`
    const is_non_active_properties = awaitdb?.executeQuery(non_active_properties)
    return {
        non_active_properties:is_non_active_properties[0].non_active_properties,
        active_properties:is_active_properties[0].active_properties,
        total_properties:is_properties[0].total_properties,
        confirmed_booking:is_confirmed[0].confirmed_booking,
        pending_booking:is_pending[0].pending_booking,
        cancelled_booking:is_cancelled[0].cancelled_booking,
        total_bookings:total_bookings[0].total_bookings,
        packages_earning:packages_earning[0].packages_earning,
        earnings_by_property:earnings_by_property,
        total_property_earnings:total_property_earnings[0].total_property_earnings}
    }
    console.log(decodedToken,'decodedToken.payload.is_visitor')
    if(decodedToken.payload.is_visitor == 1){
    var booked_properties = `select count(property_booking.id) as confirmed_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const is_confirmed = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select sum(property_booking.property_cost) + sum(property_booking.cleaning_charges) + sum(property_booking.commission) as total_purchases from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const total_purchases = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as pending_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id =  ${decodedToken.payload.user_id} and property_booking.is_confirmed=0 and is_booked=1`
    const is_pending = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as cancelled_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=0 and is_booked=0 and is_cancelled=1`
    const is_cancelled = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as total_bookings from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} `
    const total_bookings = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select sum(property_booking.property_cost) + sum(property_booking.cleaning_charges) + sum(property_booking.commission) as cost, property_booking.property_id as property_id,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1 group by property_booking.property_id,properties.name`
    const purchases_by_property = awaitdb?.executeQuery(booked_properties)
    return {confirmed_booking:is_confirmed[0].confirmed_booking,pending_booking:is_pending[0].pending_booking,cancelled_booking:is_cancelled[0].cancelled_booking,total_bookings:total_bookings[0].total_bookings,total_purchases:total_purchases[0].total_purchases,purchases_by_property:purchases_by_property}
    
    }
    if(decodedToken.payload.is_visitor == 0){
        var booked_properties = `select count(property_booking.id) as confirmed_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const is_confirmed = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select sum(property_booking.property_cost) + sum(property_booking.cleaning_charges) + sum(property_booking.commission) as total_purchases from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const total_purchases = awaitdb?.executeQuery(booked_properties)
    
    var booked_properties = `select count(property_booking.id) as pending_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id =  ${decodedToken.payload.user_id} and property_booking.is_confirmed=0 and is_booked=1`
    const is_pending = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as cancelled_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=0 and is_booked=0 and is_cancelled=1`
    const is_cancelled = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as total_bookings from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} `
    const total_bookings = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as is_confirmed_property from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const is_confirmed_property = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select COALESCE(sum(property_booking.property_cost),0) + COALESCE(sum(property_booking.cleaning_charges),0) + COALESCE(sum(property_booking.commission),0) as total_earnings from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1`
    const total_earnings = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select COALESCE(sum(property_booking.property_cost),0) + COALESCE(sum(property_booking.cleaning_charges),0) + COALESCE(sum(property_booking.commission),0) as earnings, property_booking.property_id as property_id,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1 group by property_booking.property_id,properties.name`
    const earnings_by_property = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select COALESCE(sum(property_booking.property_cost),0) as property_cost, COALESCE(sum(property_booking.cleaning_charges),0) as cleaning_charges, COALESCE(sum(property_booking.commission),0) as commission, property_booking.property_id as property_id,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1 group by property_booking.property_id,properties.name`
    const is_pending_property = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as cancelled_booking from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=0 and is_booked=0 and is_cancelled=1`
    const is_cancelled_properties = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as created_properties from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} `
    const created_properties = awaitdb?.executeQuery(booked_properties)
    var booked_properties = `select count(property_booking.id) as total_properties from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where property_booking.booked_by_user_id = ${decodedToken.payload.user_id} `
    const total_properties = awaitdb?.executeQuery(booked_properties)
    return {confirmed_booking:is_confirmed[0].confirmed_booking,
        total_bookings:total_bookings[0].total_bookings,
        total_purchases:total_purchases[0].total_purchases,
        pending_booking:is_pending[0].pending_booking,
        cancelled_booking:is_cancelled[0].cancelled_booking,
        created_properties:created_properties[0].created_properties,
        total_earnings:total_earnings[0].total_earnings,
        total_properties:total_properties[0].total_properties,
        is_confirmed_property:is_confirmed_property[0].is_confirmed_property,
        is_pending_property:is_pending_property[0].is_pending_property,
        is_cancelled_properties:is_cancelled_properties[0].is_cancelled_properties,

        earnings_by_property:earnings_by_property}
    }
    
}
async function propertyEarning(req){
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    if(decodedToken.payload.is_admin == 1){
        var booked_properties = `select  property_booking.id as invoice_number,property_booking.*,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id where  property_booking.is_confirmed=1  order by property_booking.id desc LIMIT ${req.body.top} OFFSET ${req.body.skip}`
        const earnings_by_property_detailed = awaitdb?.executeQuery(booked_properties)
        const total_count = `select  property_booking.*,properties.name as property_name from properties left join property_booking on properties.id=property_booking.property_id where  property_booking.is_confirmed=1  order by property_booking.id `
        const count = awaitdb?.executeQuery(total_count)
        var response = {
            total : count.length,
            earnings_by_property_detailed:earnings_by_property_detailed
        }
        return response
    }
    if(decodedToken.payload.is_visitor == 0){
        var booked_properties = `select property_booking.id as invoice_number,properties.name,property_booking.is_confirmed,property_booking.is_cancelled,property_booking.is_booked,property_booking.booked_from_date,booked_to_date,property_booking.booked_at,property_booking.is_booked,property_booking.quantity,property_booking.commission,property_booking.host_service_fee,property_booking.cleaning_charges,property_booking.property_cost,property_booking.host_total from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1  order by property_booking.id desc LIMIT ${req.body.top} OFFSET ${req.body.skip}`
        const earnings_by_property_detailed = awaitdb?.executeQuery(booked_properties)
        const total_count = `select property_booking.id as invoice_number,property_booking.is_confirmed,property_booking.is_cancelled,property_booking.is_booked,property_booking.booked_from_date,booked_to_date,property_booking.booked_at,property_booking.is_booked,property_booking.quantity,property_booking.commission,property_booking.host_service_fee,property_booking.cleaning_charges,property_booking.property_cost from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=properties.created_by_user where properties.created_by_user = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1  order by property_booking.id`
        const count = awaitdb?.executeQuery(total_count)
        var response = {
            total : count.length,
            earnings_by_property_detailed:earnings_by_property_detailed
        }
        return response
    }
    if(decodedToken.payload.is_visitor == 1){
    var booked_properties = `select property_booking.id as invoice_number,properties.name,property_booking.is_confirmed,property_booking.is_cancelled,property_booking.is_booked,property_booking.booked_from_date,booked_to_date,property_booking.booked_at,property_booking.is_booked,property_booking.quantity,property_booking.service_fee,property_booking.cleaning_charges,property_booking.property_cost,property_booking.booker_total from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1  order by property_booking.id desc LIMIT ${req.body.top} OFFSET ${req.body.skip}`
    console.log(booked_properties,'booked properties')
    const earnings_by_property_detailed = awaitdb?.executeQuery(booked_properties)
    const total_count = `select property_booking.id as invoice_number,property_booking.is_confirmed,property_booking.is_cancelled,property_booking.is_booked,property_booking.booked_from_date,booked_to_date,property_booking.booked_at,property_booking.is_booked,property_booking.quantity,property_booking.service_fee,property_booking.cleaning_charges,property_booking.property_cost,property_booking.booker_total from properties left join property_booking on properties.id=property_booking.property_id left join users on users.id=property_booking.booked_by_user_id where users.id = ${decodedToken.payload.user_id} and property_booking.is_confirmed=1  order by property_booking.id`
    const count = awaitdb?.executeQuery(total_count)
    var response = {
        total : count.length,
        earnings_by_property_detailed:earnings_by_property_detailed
    }
    return response
    }

}
async function updateContent(req){
    
    const hero_section_headings_primary = req.body.hero_section_headings_primary ? req.body.hero_section_headings_primary.replace(/(\r\n|\n|\r)/gm, "") : ""
    const hero_section_headings_secondary = req.body.hero_section_headings_secondary ? req.body.hero_section_headings_secondary.replace(/(\r\n|\n|\r)/gm, "") : ""
    const content_rent_heading = req.body.content_rent_heading ? req.body.content_rent_heading.replace(/(\r\n|\n|\r)/gm, "") : ""
    const content_rent_picture = req.files?.['content_rent_picture']?.[0].filename ? '/profile_pic/' + req.files['content_rent_picture']?.[0].filename : req.body.content_rent_picture
    const content_rent_desription = req.body.content_rent_desription ? req.body.content_rent_desription.replace(/(\r\n|\n|\r)/gm, "") : ""
    const content_host_heading = req.body.content_host_heading ? req.body.content_host_heading.replace(/(\r\n|\n|\r)/gm, "") : ""
    const content_host_picture = req.files?.['content_host_picture']?.[0].filename ? '/profile_pic/' + req.files['content_host_picture']?.[0].filename : req.body.content_host_picture
    const content_host_desription = req.body.content_host_desription ? req.body.content_host_desription.replace(/(\r\n|\n|\r)/gm, "") : ""
    const topproperty_heading = req.body.topproperty_heading ? req.body.topproperty_heading.replace(/(\r\n|\n|\r)/gm, "") : ""
    const topproperty_desription = req.body.topproperty_desription ? req.body.topproperty_desription.replace(/(\r\n|\n|\r)/gm, "") : ""
    const about_heading = req.body.about_heading ? req.body.about_heading.replace(/(\r\n|\n|\r)/gm, "") : ""
    const about_description = req.body.about_description ? req.body.about_description.replace(/(\r\n|\n|\r)/gm, "") : ""
    const update_content = `update content set  hero_section_headings_primary = ?, hero_section_headings_secondary = ?, content_rent_heading = ?, content_rent_picture = ?, content_rent_desription = ?, content_host_heading = ?, content_host_picture = ?, content_host_desription = ?, topproperty_heading = ?, topproperty_desription = ?, about_heading = ?, about_description = ? where id=1`
    const values = [hero_section_headings_primary,
        hero_section_headings_secondary,
        content_rent_heading,
        content_rent_picture,
        content_rent_desription,
        content_host_heading,
        content_host_picture,
        content_host_desription,
        topproperty_heading,
        topproperty_desription,
        about_heading,
        about_description,

    ]
    const is_updated = awaitdb?.executeQuery(update_content,values)
    if(!is_updated.errno){
        var response = {}
        response.success = true
        response.message = 'Data has been successfully updated.'
        return response
    }
    return {
        success:false
    }

}
async function getContent(req){
    return awaitdb?.executeQuery('select * from content where id=1')
}
module.exports ={
    propertyBooking,
    updatePropertyStatus,
    updateProperty,
    usersList,
    userDelete,
    userUpdate,
    propertiesUpdate,
    bookingStats,
    propertiesList,
    updateContent,
    getContent,
    propertyEarning
    
}