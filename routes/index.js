var express = require('express');
var router = express.Router();
const userController = require('../controllers/users');
const propertyController = require('../controllers/properties');
const packagesController = require('../controllers/packages');
const adminController = require('../controllers/adminPanel');
const passport = require('passport');
const userService = require('../services/userService')
require('dotenv').config();
// const multer  = require('multer')
// const profile_pic_upload = multer({ dest: './public/data/profile_pic/' })
const multer = require('multer');
let fs = require('fs-extra');
var storage = multer.diskStorage({

    destination: function (req, file, cb) {

        cb(null, './public/data/profile_pic/')

    },

    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        cb(null, `${file.originalname}`);

    }

})
var property_storage = multer.diskStorage({

    destination: function (req, file, cb) {

        cb(null, './public/data/property/')

    },

    filename: function (req, file, cb) {
        const ext = file.mimetype.split("/")[1];
        cb(null, `${file.originalname}`);

    }

})

var upload = multer({ storage: storage }).fields([{name: "profile_pic"},{name: "identity_doc"}])
var upload_content = multer({ storage: storage }).fields([{name: "content_rent_picture"},{name: "content_host_picture"}])
var property_images = multer({ storage: property_storage }).fields([{name:'uploadedImages', maxCount:20},{name:'property_doc'}])
router.post('/users/signup', userController.signUp);
router.post('/users/signin', userController.signIn);
router.post('/users/userdetail',passport.authenticate('jwt', { session: false }),userService.checkUserExists, userController.userDetail);
router.get('/users/accountConfirmation/:verificationcode', userController.confirmMail);
router.post('/users/initiateResetPassword/', userController.initiateResetPassword);
router.get('/users/resetpassword/:verificationcode', userController.resetPassword);
router.post('/users/confirmresetpassword/', userController.confirmResetPassword);
router.post('/users/userStatus/',passport.authenticate('jwt', { session: false }),userService.checkUserExists, userController.userStatus);
router.post('/profiles', passport.authenticate('jwt', { session: false }),userService.checkUserExists,upload, userController.setUpProfile);
router.post('/listproperties', propertyController.listProperties);
router.post('/listuserproperties', propertyController.listUserProperties);
router.post('/viewproperty', propertyController.viewProperty);
router.post('/addproperty',passport.authenticate('jwt', { session: false }),userService.checkUserExists,property_images, propertyController.addProperty);
router.post('/listfavoriteproperty',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.listFavoriteProperty);
router.post('/addfavoriteproperty',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.addFavoriteProperty);
router.post('/listpropertyreview', propertyController.listPropertyReview);
router.post('/listbookedproperties',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.listBookedProperties);
router.post('/create-subscription',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.createSubscription);
router.post('/toprated', propertyController.topRated);
router.post('/detailedpropertieslist', propertyController.detailedListProperties);
router.post('/addpropertyreview',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.addPropertyReview);
router.post('/listserviceslanguages',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.listServicesLanguages);
router.post('/listpackages',passport.authenticate('jwt', { session: false }),userService.checkUserExists, packagesController.listPackages);
router.post('/assignpackage', packagesController.assignPackage);
router.post('/checkbooking', propertyController.checkBooking);
router.post('/bookproperty',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.bookProperty);
router.post('/instantBooking',passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.instantBooking);
router.post('/bookingslist', passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists,adminController.propertyBooking);
router.post('/bookingstats',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.bookingStats);
router.post('/updatepropertystatus',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.updatePropertyStatus);
router.post('/userslist',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.usersList);
router.post('/userdelete',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.userDelete);
router.post('/updateproperty',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.updateProperty);
router.post('/updateuser',userService.isAdmin,passport.authenticate('jwt', { session: false }),userService.checkUserExists, adminController.updateUser);
router.post('/getcontent', adminController.getContent);
router.post('/updatecontent',userService.isAdmin,passport.authenticate('jwt', { session: false }),userService.checkUserExists,upload_content, adminController.updateContent);
router.post('/propertyearning',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, adminController.propertyEarning);
router.post('/addpackage',passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists, packagesController.addPackage);
router.post('/viewpackage', packagesController.viewPackage);
router.post('/editpackages',userService.isAdmin, packagesController.editPackages);
router.post('/editproperties',passport.authenticate('jwt', { session: false }),userService.checkUserExists,property_images, adminController.editProperties);
router.post('/propertieslist', passport.authenticate('jwt', { session: false }),userService.isAdmin,userService.checkUserExists,adminController.propertiesList);
router.post("/create-checkout-session",passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.payment);
router.post("/create-refund",passport.authenticate('jwt', { session: false }),userService.checkUserExists, propertyController.refund);
module.exports = router;
