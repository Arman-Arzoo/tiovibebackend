const validator = require('../helpers/validator');
var multer_helper = require('../helpers/multer');
const send_email = require('../helpers/sendEmail');
var jwt = require("jsonwebtoken")
const bcrypt = require('bcryptjs')
const db = require('./db.js');
const path = require('path');
const { response } = require('../app');
require('dotenv').config();

async function listPackages(req){
    return awaitdb?.executeQuery('select * from hosts_packages','')
}
async function viewPackage(req){
    var response = {}
    const validationRule = {
        "package_id": "required|numeric",
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
    const package_detail = awaitdb?.executeQuery(`select * from hosts_packages where id =${req.body.package_id}`)
    response.success = true
    response.data = package_detail
    return response
}
async function editPackages(req){
    var response = {}
    const validationRule = {
        "package_name": "required|string",
        "commission": "required|numeric",
        "price": "required|numeric",
        "package_id": "required|numeric",
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
    const package_updated = awaitdb?.executeQuery(`update hosts_packages set package_name = ${req.body.package_name}, commission = ${req.body.commission}, price = ${req.body.price} where id=${req.body.package_id}`)
    if (!package_updated.errno){
        response.success = true
        response.message = 'Package updated successfully.'
        return response
    }

}
async function addPackage(req){
    var response = {}
    const validationRule = {
        "package_name": "required|string",
        "package_commission": "required|numeric",
        "package_price": "required|numeric",
        "is_premium": "required|numeric",
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
    const package_name = req.body.package_name
    const package_commission = req.body.package_commission
    const package_price = req.body.package_price
    const is_premium = req.body.is_premium
    const package_add_query = 'insert into hosts_package values (?,?,?,?)'
    const add_package_values = [package_name,package_price,package_commission,is_premium]
    const package_added = awaitdb?.executeQuery(package_add_query,add_package_values)
    response.success = true
    response.message = 'Package added successfully.'
    return response
}
async function packagePayment(req){
    var response = {}
    response.success = false
    response.payment_verified = 0
    const first_name = req.body.first_name ? req.body.first_name : ''
    const last_name = req.body.last_name ? req.body.last_name :''
    const country = req.body.country ? req.body.country : ''
    const address = req.body.address ? req.body.address : ''
    const city = req.body.city ? req.body.city : ''
    const province = req.body.province ? req.body.province : ''
    const postal_code = req.body.postal_code ? req.body.postal_code : ''
    const phone = req.body.phone ? req.body.phone : ''
    const email = req.body.email ? req.body.email : ''
    const price = req.body.price ? req.body.price : ''
    const validationRule = {
        "first_name": "required|string",
        "last_name": "required|string",
        "country": "required|string",
        "address": "required|string",
        "city": "required|string",
        "province": "required|string",
        "postal_code": "required|string",
        "phone": "required|string",
        "email": "required|string|email",
        "price": "required|string",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            response.payment_verified = 0
            return response
        }
    }).catch( err => console.log(err))
    const payment_verified = 1 //need to be change to payment method
    if (response.payment_verified){
        response.message = 'Payment Successfull.'
        return response
    }
    return payment_verified
}
async function assignPackage(req){
    var response = {}
    response.success = false
    const validationRule = {
        "package_id": "required|numeric",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        return response
    }
    })
    if (response.err){
        return response
    }
    // var payment_status = await packagePayment(req)
    // if (!payment_status.success){
    //     return payment_status
    // }
    response.message = 'Something went wrong.'
    const package_id = req.body.package_id
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const user_id = [decodedToken.payload.user_id]
    if (!user_id){
        response.success = false
        response.message = "Validation failed"
        response.err = {
            errors : {
                user_id :[
                    "The user id is required."
                ]
            }
        }
        return response
    }
    const delete_package = `delete from user_packages where user_id = ?`
    const package_added_query = `insert into user_packages (package_id,user_id) values (?,?)`
    const package_added_values = [package_id,user_id]
    const package_deleted = awaitdb?.executeQuery(delete_package,[user_id])
    const package_added = awaitdb?.executeQuery(package_added_query,package_added_values)
    const query = 'select users.*,package_id,packages_name,comission,languages.*,services.id as service_id,service_name,languages.id as lang_id, languages.name as lang_name from users left join user_packages on users.id = user_packages.user_id left join hosts_packages on user_packages.package_id = hosts_packages.id left join user_languages on users.id=user_languages.user_id left join user_services on users.id=user_services.user_id left join languages on user_languages.language_id=languages.id left join services on user_services.service_id=services.id where users.id = ?'
    const values = [user_id]
    const user = awaitdb?.executeQuery(query,values)
    var user_detail = {}
    user_detail.email = user[0].email
    user_detail.username = user[0].username
    user_detail.first_name = user[0].first_name
    user_detail.last_name = user[0].last_name
    // user_detail.token = token
    user_detail.phone_number = user[0].phone_number
    user_detail.created_at = user[0].created_at
    user_detail.last_login = user[0].last_login
    // user_detail.token_detail = jwt.decode(token)
    user_detail.is_visitor = user[0].is_visitor
    user_detail.profile_pic = user[0].profile_pic
    user_detail.identification_doc = user[0].identification_doc
    user_detail.profile_info = user[0].profile_info
    user_detail.service_id = user[0].service_id
    user_detail.service_name = user[0].service_name
    user_detail.lang_id = user[0].lang_id
    user_detail.lang_name = user[0].lang_name
    if (user[0].package_id !=null || user[0].package_id != undefined){
        var package = {}
        package.package_id = user[0].package_id
        package.package_name = user[0].packages_name
        package.package_comission = user[0].comission
        package.is_premium = user[0].is_premium
        user_detail.package = package
    }
    // user_detail.token_detail.exp = moment(user_detail.token_detail.exp * 1000).format("DD MMM YYYY H:mm")
    // console.log(new Date(user_detail.token_detail.exp))
    // console.log(user_detail)
    response.user_detail = user_detail
    if(!package_added.errno){
        response.success = true
        response.message = 'Package selected successfully'
        
    }
    return response
}
module.exports = {
    listPackages,
    assignPackage,
    addPackage,
    viewPackage,
    editPackages
}