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
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
require('dotenv').config();
async function signupService(req,res){
    var response = {}
    response.success = false
    
    const validationRule = {
        "email": "required|string|email",
        "username": "required|string",
        // "password": "required|string|min:6",
        "password": "required|string|min:1",
        "phone_number": "required|string|min:1|max:40",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
    if (!status) {
        response.success = false,
        response.message = 'Validation failed',
        response.err = err
        return response
    }
    }).catch( err => console.log(err))
    if (!response.err){
        const username  = req.body?.username
        const phone_number  = req.body?.phone_number
        const salt = await bcrypt.genSalt(10)
        const password = await bcrypt.hash(req.body?.password, salt)
        console.log(password,'password')
        const email = req.body?.email
        const is_active = 1
        const is_deleted = 0
        const is_admin = 0
        const is_verified = 0
        const last_login = null
        const created_at = new Date()
        const is_visitor = req.body.is_visitor
        var output;
        const check_user_existence = `select * from users where username = ? or email = ?`
        const check_users_value = [username,email]
        const is_user_exists = awaitdb?.executeQuery(check_user_existence,check_users_value)
        if(!is_user_exists.errno){
            if(is_user_exists.length > 0){
                response.success = false
                response.message = "User already exists"
                response.err = {
                    errors : {
                        user_id :[
                            "User already exists."
                        ]
                    }
                }
                return response
            }
        }
        const customer = await stripe.customers.create({
            email: email,
            name:username
          });
        const query = 'insert into users (username,email,is_active,is_deleted,is_admin,is_verified,password,last_login,created_at,verification_token,phone_number,is_visitor,profile_status,customer_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)'
        const verification_token = jwt.sign({email: email}, process.env.JWT_TOKEN_KEY)
        const values = [username,email,is_active,is_deleted,is_admin,is_verified,password,last_login,created_at,verification_token,phone_number,is_visitor,1,customer.id]
        console.log(values)
        const create_user = awaitdb?.executeQuery(query,values)
        if (create_user.errno){
            response.success = false
            response.message = create_user.sqlMessage
            return response
        }
        const subject = "Please confirm your account"
        const email_msg = `Your account hase been successfully created. Use this link to activate your account. <a href="http://${process.env.BASE_URL_EMAIL_CLIENT_SIDE}/verified/${verification_token}">Click here to confirm</a>`
        const email_sent = await send_email.sendMail(email,'',email_msg,subject)
        response.success = true
        response.message = 'User created successfully.'
        return response
    }
    return response
}

async function confirmMail(req,res){
    const query = 'select * from users where is_active=1 and is_deleted=0 and is_verified=0 and verification_token=?'
    const values = [req.params.verificationcode]
    const found_user = awaitdb?.executeQuery(query,values)
    if (found_user.length > 0){
        const query = 'update users  set is_verified=? where id=?'
        const values = [1,found_user[0].id]
        const user_verified = awaitdb?.executeQuery(query,values)
        console.log(user_verified)
        
        return {
            success: true,
            message:"You have been successfully verified."
        }
    }
    return {
        success: false,
        message: 'User does not exists.'
    }
    
}
async function initiateResetPassword(req,res){
    var response = {}
    response.message = []
    response.success = false
    const validationRule = {
        "username": "required|string",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
        console.log(req.body)
    }).catch( err => console.log(err))
    if(response.err){
        return response
    }
    const query = 'select * from users where email = ? or username = ?'
    const values = [req.body.username,req.body.username]
    const found_user = awaitdb?.executeQuery(query,values)
    if (found_user.length == 0) {
        response.message.push({
            invalid_email:"User does not exist."
        })
        return response
    }
    if(found_user[0].is_active == 0){
        response.message.push({
            inactive_user:"User is inactive."
        })
    }
    if(found_user[0].is_deleted == 1){
        response.message.push({
            not_exists:"User has been deleted."
        })
    }
    if(found_user[0].is_verified == 0){
        response.message.push({
            not_verified:"User is not verified."
        })
    }
    if(found_user.length == 0 || found_user[0].is_active == 0 || found_user[0].is_deleted == 1 || found_user[0].is_verified == 0){
        return response
    }
    try{
        if (found_user.length > 0){
            const verification_token = jwt.sign({username: req.body.username}, process.env.RESET_JWT_TOKEN_KEY,{
                expiresIn: "24h",
            })
            const update_user_query = 'update users set reset_password_token = ? where username = ? or email = ?'
            const update_user_values = [verification_token,req.body.username,req.body.username]
            const update_user = awaitdb?.executeQuery(update_user_query,update_user_values)
            console.log(update_user,'update_user')
            const subject = "Password Reset"
            const email_msg = `Your request for password reset has been completed. <a href="http://${process.env.BASE_URL_EMAIL_CLIENT_SIDE}/reset-password/${verification_token}">Click here to reset password</a>`
            const email_sent = await send_email.sendMail(found_user[0].email,'',email_msg,subject)
            if(email_sent){
            return {
                success: true,
                message: 'Email has been sent successfully. Check your inbox.'
            }
            }
        }
    }   
    catch (error){
        response.success = false
        response.message = 'Something went wrong.'
        console.log(error)
        return response
    }
}
async function resetPassword(req,res){
    var response = {}
    response.success = false
    response.message = []
    const validationRule = {
        "verificationcode": "required|string",
    };
    await validator(req.params, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
    })
    const is_verified_token = jwt.verify(req.params.verificationcode, process.env.RESET_JWT_TOKEN_KEY,
        (err, verifiedJwt) => {
            if(err){
              console.log(err.message)
              response.success = false
              response.message = err.message
              response.err = true
              return response
            }else{
              console.log(verifiedJwt,'verified token')
            }
        })
    console.log(response,'===================')
    if (response.err){
        return response
    }
    console.log(is_verified_token,'is_verified_token')
    const query = 'select * from users where reset_password_token = ?'
    console.log(query)
    const values = [req.params.verificationcode]
    const found_user = awaitdb?.executeQuery(query,values)
    if (found_user.length == 0) {
        response.message.push({
            invalid_token:"User does not exist."
        })
        return response
    }
    if(found_user[0].is_active == 0){
        response.message.push({
            inactive_user:"User is inactive."
        })
    }
    if(found_user[0].is_deleted == 1){
        response.message.push({
            not_exists:"User has been deleted."
        })
    }
    if(found_user[0].length == 0 || found_user[0].is_active == 0 || found_user[0].is_deleted == 1){
        return response
    }
    if (found_user.length > 0){
            response.success = true
            response.user_detail = {}
            response.user_detail.id = found_user[0].id
            response.user_detail.username = found_user[0].username
            response.user_detail.email = found_user[0].email
            response.reset_password_token = found_user[0].reset_password_token
        }
    return response
}

async function confirmResetPassword(req){
    var response = {}
    response.message = []
    const query = 'select * from users where reset_password_token = ? and username = ? or email = ?'
    const validationRule = {
        "username": "required|string",
        "token": "required|string",
        "password": "required|string",
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
    const is_verified_token = jwt.verify(req.body.token, process.env.RESET_JWT_TOKEN_KEY,
        (err, verifiedJwt) => {
            if(err){
              console.log(err.message)
              response.success = false
              response.err = true
              response.message = err.message
              return response
            }else{
              console.log(verifiedJwt)
            }
        })
    if (response.err){
        return response
    }
    const salt = await bcrypt.genSalt(10)
    const password = await bcrypt.hash(req.body?.password, salt)
    const values = [req.body.token,req.body.username,req.body.username]
    const user = awaitdb?.executeQuery(query,values)
    console.log(user)
    console.log(query)
    console.log(values)
    if (user.length == 0) {
        response.message.push({
            invalid_email:"Invalid token."
        })
        return response
    }
    if(user.is_active == 0){
        response.message.push({
            inactive_user:"User is inactive."
        })
    }
    if(user.is_deleted == 1){
        response.message.push({
            not_exists:"User does not exists."
        })
    }
    if(user.length == 0  || user.is_active == 0 || user.is_deleted == 1){
        return response
    }
    const update_query = 'update users set password = ? where reset_password_token = ?'
    const update_values = [password,req.body.token]
    const update_user = awaitdb?.executeQuery(update_query,update_values)
    console.log(update_user)
    if (update_user.affectedRows > 0){
        return {
            success: true,
            message: 'Password hase been updated successfully.'
        }
    }

}
async function setUpProfile(req){
    const pic_name = req.files?.['profile_pic']?.[0].filename ? '/profile_pic/' + req.files['profile_pic']?.[0].filename : ''
    const languages = req.body.languages
    const services = req.body.services
    const first_name = req.body.first_name ?  req.body.first_name : ''
    const last_name = req.body.last_name ?  req.body.last_name : ''
    const identity_doc = req.files?.['identity_doc']?.[0].filename ?  '/profile_pic/' + req.files['identity_doc'][0].filename : ''
    const country = req.body.country ?  req.body.country : ''
    var response = {}
    response.message = []
    response.success = false
    const query = 'select * from users where id=?'
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
       });
    const select_values = [decodedToken.payload.user_id]
    console.log(languages)
    const user_details = awaitdb?.executeQuery(query,select_values)
    const validationRule = {
        "languages": "required|array",
        "services": "required|array",
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
    if (user_details.length > 0){
        const update_user_query = 'update users set profile_pic = ?, first_name = ? , last_name = ? , identification_doc = ?, country = ? where id = ?'
        const update_user_values = [pic_name,first_name,last_name,identity_doc,country,decodedToken.payload.user_id]
        const update_user_status = awaitdb?.executeQuery(update_user_query,update_user_values)
        console.log(req.file,'update user')
        console.log(update_user_status.affectedRows,'update user')
        if (update_user_status.affectedRows > 0){
        }
        const select_profile_query = `select * from users where id = ?`
        const select_profile_values = [decodedToken.payload.user_id]
        const profile_status = awaitdb?.executeQuery(select_profile_query,select_profile_values)
        console.log(profile_status,'profile_status')
        if (profile_status.length > 0){
            const delete_lang_query = `delete from user_languages where user_id = ?`
            const delete_services_query = `delete from user_services where user_id = ?`
            const deleted_lang = awaitdb?.executeQuery(delete_lang_query,[decodedToken.payload.user_id])
            const deleted_services = awaitdb?.executeQuery(delete_services_query,[decodedToken.payload.user_id])
        }
            const update_lang_query = `insert into user_languages (user_id,language_id) values ?`
            const update_services_query = `insert into user_services (user_id,service_id) values ?`
            const services_array = []
            const languages_array = []
            for (var i in languages){
                const arr = []
                arr.push(decodedToken.payload.user_id)
                arr.push(languages[i])
                languages_array.push(arr)
            }
            for (var i in services){
                const arr = []
                arr.push(decodedToken.payload.user_id)
                arr.push(services[i])
                console.log(arr,'arr')
                services_array.push(arr)
            }
            // const update_lang_values = languages_array
            // const update_services_values = services_array
            
            const inserted_services = awaitdb?.executeQuery(update_lang_query,[languages_array])
            const inserted_lang = awaitdb?.executeQuery(update_services_query,[services_array])
            console.log(inserted_lang,'inserted_lang')
            console.log(inserted_services,'inserted_lang')
            response.message.push('User hase been updated successfully.')
            response.success = true


    }
    return response
}
async function signIn(req){
    var response = {}
    response.success = false
    if(req.body.is_gmail){
        const validationRule = {
            "token": "required|string",
        };
        await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message = 'Validation failed',
            response.err = err
            return response
        }
        }).catch( err => console.log(err))
        console.log(response)
        if(response.err){
            return response
        }
        const is_verified = await verifyGoogleToken(req.body.token)
        if (is_verified.success != false){
            console.log(is_verified.data.email)
            const check_user = `select users.*,package_id,packages_name,comission,services.id as service_id,service_name,languages.id as lang_id, languages.name as lang_name from users left join user_packages on users.id = user_packages.user_id left join hosts_packages on user_packages.package_id = hosts_packages.id left join user_languages on users.id=user_languages.user_id left join user_services on users.id=user_services.user_id left join languages on user_languages.language_id=languages.id left join services on user_services.service_id=services.id where email='${is_verified.data.email}' or username='${is_verified.data.email}'`
            const is_user_exists = awaitdb?.executeQuery(check_user)
            if (is_user_exists.length > 0){
                if (is_user_exists[0].password == '' || is_user_exists[0].password == null || is_user_exists[0].password == undefined){
                const token = jwt.sign(
                    { user_id: is_user_exists[0].id, user_name:is_user_exists[0].username,is_admin:is_user_exists[0].is_admin,is_visitor:is_user_exists[0].is_visitor },
                    process.env.JWT_TOKEN_KEY,
                    {
                        expiresIn: "1d",
                    }
                    );
                var user_detail = {}
                user_detail.email = is_user_exists[0].email
                user_detail.username = is_user_exists[0].username
                user_detail.first_name = is_user_exists[0].first_name
                user_detail.last_name = is_user_exists[0].last_name
                user_detail.token = token
                user_detail.phone_number = is_user_exists[0].phone_number
                user_detail.created_at = is_user_exists[0].created_at
                user_detail.last_login = is_user_exists[0].last_login
                user_detail.token_detail = jwt.decode(token)
                user_detail.is_visitor = is_user_exists[0].is_visitor
                user_detail.profile_pic = is_user_exists[0].profile_pic
                user_detail.identification_doc = is_user_exists[0].identification_doc
                user_detail.profile_info = is_user_exists[0].profile_info
                user_detail.service_id = is_user_exists[0].service_id
                user_detail.service_name = is_user_exists[0].service_name
                user_detail.lang_id = is_user_exists[0].lang_id
                user_detail.lang_name = is_user_exists[0].lang_name
                user_detail.customer_id = is_user_exists[0].customer_id
                if (is_user_exists[0].package_id !=null || is_user_exists[0].package_id != undefined){
                    var package = {}
                    package.package_id = is_user_exists[0].package_id
                    package.package_name = is_user_exists[0].packages_name
                    package.package_comission = is_user_exists[0].comission
                    package.is_premium = is_user_exists[0].is_premium
                    user_detail.package = package
                }
                // user_detail.token_detail.exp = moment(user_detail.token_detail.exp * 1000).format("DD MMM YYYY H:mm")
                console.log(new Date(user_detail.token_detail.exp))
                console.log(user_detail)
                response.success = true
                response.message = 'User successfully logged in.'
                response.user_detail = user_detail
                return response
            }
            else{
                response.success = false
                response.message = 'Regular user already exists.'
                return response
            }
            }
            else{
                const customer = await stripe.customers.create({
                    email: data.email,
                    name:data.given_name
                  });
                const create_user = `insert into users (email,username,is_verified,is_active,profile_pic,first_name,last_name,password,is_deleted,verification_token,is_admin,created_at,profile_status,customer_id) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)`
                const create_user_values = [is_verified.data.email,is_verified.data.email,1,1,is_verified.data.picture,is_verified.data.given_name,is_verified.data.family_name,'',0,'',0,new Date(),0,customer.id]
                const user_created = awaitdb?.executeQuery(create_user,create_user_values)
                if (!user_created.errno){
                    const check_user = `select users.*,package_id,packages_name,comission,services.id as service_id,service_name,languages.id as lang_id, languages.name as lang_name from users left join user_packages on users.id = user_packages.user_id left join hosts_packages on user_packages.package_id = hosts_packages.id left join user_languages on users.id=user_languages.user_id left join user_services on users.id=user_services.user_id left join languages on user_languages.language_id=languages.id left join services on user_services.service_id=services.id where email='${is_verified.data.email}' or username='${is_verified.data.email}'`
            const is_user_exists = awaitdb?.executeQuery(check_user)
            if (is_user_exists.length > 0){
                if (is_user_exists[0].password == '' || is_user_exists[0].password == null || is_user_exists[0].password == undefined){
                const token = jwt.sign(
                    { user_id: is_user_exists[0].id, user_name:is_user_exists[0].username,is_admin:is_user_exists[0].is_admin,is_visitor:is_user_exists[0].is_visitor },
                    process.env.JWT_TOKEN_KEY,
                    {
                        expiresIn: "1d",
                    }
                    );
                var user_detail = {}
                user_detail.email = is_user_exists[0].email
                user_detail.username = is_user_exists[0].username
                user_detail.first_name = is_user_exists[0].first_name
                user_detail.last_name = is_user_exists[0].last_name
                user_detail.token = token
                user_detail.phone_number = is_user_exists[0].phone_number
                user_detail.created_at = is_user_exists[0].created_at
                user_detail.last_login = is_user_exists[0].last_login
                user_detail.token_detail = jwt.decode(token)
                user_detail.is_visitor = is_user_exists[0].is_visitor
                user_detail.profile_pic = is_user_exists[0].profile_pic
                user_detail.identification_doc = is_user_exists[0].identification_doc
                user_detail.profile_info = is_user_exists[0].profile_info
                user_detail.service_id = is_user_exists[0].service_id
                user_detail.service_name = is_user_exists[0].service_name
                user_detail.lang_id = is_user_exists[0].lang_id
                user_detail.lang_name = is_user_exists[0].lang_name
                user_detail.customer_id = is_user_exists[0].customer_id
                if (is_user_exists[0].package_id !=null || is_user_exists[0].package_id != undefined){
                    var package = {}
                    package.package_id = is_user_exists[0].package_id
                    package.package_name = is_user_exists[0].packages_name
                    package.package_comission = is_user_exists[0].comission
                    package.is_premium = is_user_exists[0].is_premium
                    user_detail.package = package
                }
                // user_detail.token_detail.exp = moment(user_detail.token_detail.exp * 1000).format("DD MMM YYYY H:mm")
                console.log(new Date(user_detail.token_detail.exp))
                console.log(user_detail)
                response.success = true
                response.message = 'User successfully logged in.'
                response.user_detail = user_detail
                return response
                }
            return response
            }
        return response}
    return response
    }
    
        return response
        }
        return response
    }
    response.message = []
    const username = req.body.username
    const password = req.body.password
    const validationRule = {
        "username": "required|string",
        "password": "required|string",
    };
    await validator(req.body, validationRule, {}, (err, status) => {
        if (!status) {
            response.success = false,
            response.message.push('Validation failed'),
            response.err = err
            return response
        }
    })
    const query = 'select users.*,package_id,packages_name,comission,services.id as service_id,service_name,languages.id as lang_id, languages.name as lang_name from users left join user_packages on users.id = user_packages.user_id left join hosts_packages on user_packages.package_id = hosts_packages.id left join user_languages on users.id=user_languages.user_id left join user_services on users.id=user_services.user_id left join languages on user_languages.language_id=languages.id left join services on user_services.service_id=services.id where email = ? or username = ?'
    const values = [username,username]
    const user = awaitdb?.executeQuery(query,values)
    console.log(user,'user')
        if (user.length ==0) {
        response.message.push({
            invalid_email:"Email or username is incorrect."
        })
        return response
    }
    if (!(await bcrypt.compare(password, user[0].password)))
    {
        response.message.push({
            invalid_password:"Password is incorrect."
        })
    }
    if(user[0].is_active == 0){
        response.message.push({
            inactive_user:"User is inactive."
        })
    }
    if(user[0].is_verified == 0){
        response.message.push({
            not_verified:"User is not verified."
        })
    }
    if(user[0].is_deleted == 1){
        response.message.push({
            not_exists:"User does not exists."
        })
    }
    if(user.length == 0 || !(await bcrypt.compare(password, user[0].password)) || user[0].is_active == 0 || user[0].is_deleted == 1 || user[0].is_verified == 0){
        return response
    }

    // Create token
    const update_user = 'update users set last_login=? where id=?'
    const update_values = [new Date(),user[0].id]
    const update_results = awaitdb?.executeQuery(update_user,update_values)
    console.log(user[0].id,'user exists')
    const token = jwt.sign(
    { user_id: user[0].id, user_name:username,is_admin:user[0].is_admin,is_visitor:user[0].is_visitor },
    process.env.JWT_TOKEN_KEY,
    {
        expiresIn: "1d",
    }
    );
    var user_detail = {}
    user_detail.email = user[0].email
    user_detail.username = user[0].username
    user_detail.first_name = user[0].first_name
    user_detail.last_name = user[0].last_name
    user_detail.token = token
    user_detail.phone_number = user[0].phone_number
    user_detail.created_at = user[0].created_at
    user_detail.last_login = user[0].last_login
    user_detail.token_detail = jwt.decode(token)
    user_detail.is_visitor = user[0].is_visitor
    user_detail.profile_pic = user[0].profile_pic
    user_detail.identification_doc = user[0].identification_doc
    user_detail.profile_info = user[0].profile_info
    user_detail.service_id = user[0].service_id
    user_detail.service_name = user[0].service_name
    user_detail.lang_id = user[0].lang_id
    user_detail.lang_name = user[0].lang_name
    user_detail.customer_id = user[0].customer_id
    if (user[0].package_id !=null || user[0].package_id != undefined){
        var package = {}
        package.package_id = user[0].package_id
        package.package_name = user[0].packages_name
        package.package_comission = user[0].comission
        package.is_premium = user[0].is_premium
        user_detail.package = package
    }
    // user_detail.token_detail.exp = moment(user_detail.token_detail.exp * 1000).format("DD MMM YYYY H:mm")
    console.log(new Date(user_detail.token_detail.exp))
    console.log(user_detail)
    response.success = true
    response.message = 'User successfully logged in.'
    response.user_detail = user_detail
    return response
}


// async function verifyGoogleToken(req) {
//   try {
//     console.log(client,'qwerty')
//     const ticket = await client.verifyIdToken({
//       idToken: req.body.token,
//       audience: GOOGLE_CLIENT_ID,
//     });
//     return { payload: ticket.getPayload() };
//   } catch (error) {
//     console.log(error)
//     return { error: "Invalid user detected. Please try again" };
//   }
// }
async function verifyGoogleToken(token) {
    var response = {}
    try{
    const { data } = await axios({
      url: 'https://www.googleapis.com/oauth2/v2/userinfo',
      method: 'get',
      headers: {
        Authorization: `Bearer ${token}`,
      },
    });
    console.log(data); // { id, email, given_name, family_name }
    response.success = true
    response.data = data
    return response;
    }
    catch(error){
        console.log(error)
        response.success = false
        response.status_code = error.response.data.error.code
        response.message = error.response.data.error.message
        return response
    }   
  };
async function userDetail(req){
    var response = {}
    const decodedToken = jwt.decode(req.headers.authorization.split(' ')[1], {
        complete: true
    });
    const user_id = decodedToken.payload.user_id

    const query = 'select users.*,package_id,packages_name,comission,services.id as service_id,service_name,languages.id as lang_id, languages.name as lang_name from users left join user_packages on users.id = user_packages.user_id left join hosts_packages on user_packages.package_id = hosts_packages.id left join user_languages on users.id=user_languages.user_id left join user_services on users.id=user_services.user_id left join languages on user_languages.language_id=languages.id left join services on user_services.service_id=services.id where users.id = ?'
    const values = [user_id]
    const user_languages = `select * from languages left join user_languages on languages.id=user_languages.language_id  where user_id=${user_id}`
    const user_services = `select * from services left join user_services on services.id=user_services.service_id where user_id=${user_id}`
    const is_user_languages = awaitdb?.executeQuery(user_languages)
    const is_user_services = awaitdb?.executeQuery(user_services)
    const user = awaitdb?.executeQuery(query,values)
    var user_detail = {}
    user_detail.email = user[0].email
    user_detail.username = user[0].username
    user_detail.first_name = user[0].first_name
    user_detail.last_name = user[0].last_name
    user_detail.phone_number = user[0].phone_number
    user_detail.created_at = user[0].created_at
    user_detail.last_login = user[0].last_login
    user_detail.is_visitor = user[0].is_visitor
    user_detail.profile_pic = user[0].profile_pic
    user_detail.identification_doc = user[0].identification_doc
    user_detail.profile_info = user[0].profile_info
    user_detail.languages = is_user_languages
    user_detail.services = is_user_services
    user_detail.lang_id = user[0].lang_id
    user_detail.lang_name = user[0].lang_name
    user_detail.profile_status = user[0].profile_status
    user_detail.customer_id = user[0].customer_id
    if (user[0].package_id !=null || user[0].package_id != undefined){
        var package = {}
        package.package_id = user[0].package_id
        package.package_name = user[0].packages_name
        package.package_comission = user[0].comission
        package.is_premium = user[0].is_premium
        user_detail.package = package
    }
    response.success = true
    response.message = 'User Detail'
    response.user_detail = user_detail
    return response
}
async function userStatus(req){
    try{ 
    const decodedToken = jwt.decode(req.headers?.authorization?.split(' ')[1], {
        complete: true
    });
    if(!decodedToken){
        return {
            success:false,
            message:"Token is required"
        }
    }
    const user_id = decodedToken.payload.user_id
    const query = `update users set profile_status = 1, is_visitor = ${req.body.is_visitor} where id=${user_id} `
    const user_status = awaitdb?.executeQuery(query)
    console.log(user_status)
    return {
        success:true,
        message:'User updated successfully.'
    }
    }
    catch(err){
        return {
            success:false,
            message:'Something went wrong.'
        }
    }
}
async function checkUserExists(req, res, next) {
    const decodedToken = jwt.decode(req.headers?.authorization?.split(' ')[1], {
        complete: true
    });
    const userId = decodedToken?.payload?.user_id; // You should replace this with how you store user information in your application
    if (!userId){
        return res.status(500).json({ error: 'Please login.' });
    }
    const query = 'SELECT * FROM users WHERE id = ?';
    const user = awaitdb?.executeQuery(query,userId);
      if (user.err) {
        console.error(err);
        return res.status(500).json({ error: 'Database error' });
      }
  
      if (user.length === 0) {
        return res.status(404).json({ error: 'User not found' });
      }
  
      // User exists in the database; you can attach user data to the request object if needed
      req.user = user[0];
      next();
}
async function isAdmin(req, res, next) {
    const decodedToken = jwt.decode(req.headers?.authorization?.split(' ')[1], {
        complete: true
    });
    const userId = decodedToken?.payload?.user_id; // You should replace this with how you store user information in your application
    if (!userId){
        return res.status(401).json({ error: 'Please login.', success:false});
    }
    const query = 'SELECT * FROM users WHERE id = ?';
    const user = awaitdb?.executeQuery(query,userId);
      if (user.err) {
        console.error(err);
        return res.status(500).json({ error: 'Database error',success:false });
      }
  
      if (user.length === 0) {
        return res.status(404).json({ error: 'User not found',success:false });
      }
      if (user[0].is_admin == 0){
        return res.status(401).json({ error: 'You are not authorized.',success:false });
      }
      // User exists in the database; you can attach user data to the request object if needed
      req.user = user[0];
      next();
}
module.exports = {
    signupService,
    confirmMail,
    signIn,
    setUpProfile,
    initiateResetPassword,
    resetPassword,
    confirmResetPassword,
    verifyGoogleToken,
    userDetail,
    userStatus,
    checkUserExists,
    isAdmin
}