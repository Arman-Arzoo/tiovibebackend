const propertyService = require('../services/properties')
const stripe = require('../services/stripe')
async function listProperties(req,res){
    const listing = await propertyService.listProperties(req,res) 
    res.json({response:listing})
}
async function viewProperty(req,res){
    const view = await propertyService.viewProperty(req,res) 
    res.json({response:view})
}
async function addProperty(req,res){
    const view = await propertyService.addProperty(req,res) 
    res.json({response:view})
}
async function listFavoriteProperty(req,res){
    const view = await propertyService.listFavoriteProperty(req,res) 
    res.json({response:view})
}
async function addFavoriteProperty(req,res){
    const view = await propertyService.addFavoriteProperty(req,res) 
    res.json({response:view})
}
async function listPropertyReview(req,res){
    const view = await propertyService.listPropertyReview(req,res) 
    res.json({response:view})
}
async function addPropertyReview(req,res){
    const view = await propertyService.addPropertyReview(req,res) 
    res.json({response:view})
}
async function listServicesLanguages(req,res){
    const view = await propertyService.listServicesLanguages(req,res) 
    res.json({response:view})
}
async function checkBooking(req,res){
    const view = await propertyService.checkBooking(req,res) 
    res.json({response:view})
}
async function bookProperty(req,res){
    const view = await propertyService.bookProperty(req,res) 
    res.json({response:view})
}
async function listUserProperties(req,res){
    const view = await propertyService.listUserProperties(req,res) 
    res.json({response:view})
}
async function instantBooking(req,res){
    const view = await propertyService.instantBooking(req,res) 
    res.json({response:view})
}
async function listBookedProperties(req,res){
    const view = await propertyService.listBookedProperties(req,res) 
    res.json({response:view})
}
async function topRated(req,res){
    const view = await propertyService.topRated(req,res) 
    res.json({response:view})
}
async function detailedListProperties(req,res){
    const view = await propertyService.detailedListProperties(req,res) 
    res.json({response:view})
}
async function createSubscription(req,res){
    const view = await propertyService.createSubscription(req,res) 
    res.json({response:view})
}
async function payment(req,res){
    const view = await stripe.payment(req,res) 
    res.json({response:view})
}
async function refund(req,res){
    const view = await stripe.refund(req,res) 
    res.json({response:view})
}
module.exports = {
    listProperties,
    viewProperty,
    addProperty,
    addFavoriteProperty,
    listFavoriteProperty,
    listPropertyReview,
    addPropertyReview,
    listServicesLanguages,
    checkBooking,
    bookProperty,
    listUserProperties,
    instantBooking,
    listBookedProperties,
    topRated,
    detailedListProperties,
    createSubscription,
    payment,
    refund
}