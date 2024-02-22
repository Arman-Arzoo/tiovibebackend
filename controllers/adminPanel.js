const admin_panel =  require('../services/adminPanelService')

async function propertyBooking(req,res){
    const listing = await admin_panel.propertyBooking(req,res) 
    res.json({response:listing})
}
async function updatePropertyStatus(req,res){
    const listing = await admin_panel.updatePropertyStatus(req,res) 
    res.json({response:listing})
}
async function usersList(req,res){
    const listing = await admin_panel.usersList(req,res) 
    res.json({response:listing})
}
async function userDelete(req,res){
    const listing = await admin_panel.userDelete(req,res) 
    res.json({response:listing})
}
async function updateProperty(req,res){
    const listing = await admin_panel.propertiesUpdate(req,res) 
    res.json({response:listing})
}
async function updateUser(req,res){
    const listing = await admin_panel.userUpdate(req,res) 
    res.json({response:listing})
}
async function editProperties(req,res){
    const listing = await admin_panel.updateProperty(req,res) 
    res.json({response:listing})
}
async function bookingStats(req,res){
    const listing = await admin_panel.bookingStats(req,res) 
    res.json({response:listing})
}
async function propertiesList(req,res){
    const listing = await admin_panel.propertiesList(req,res) 
    res.json({response:listing})
}

async function getContent(req,res){
    const listing = await admin_panel.getContent(req,res) 
    res.json({response:listing})
}

async function updateContent(req,res){
    const listing = await admin_panel.updateContent(req,res) 
    res.json({response:listing})
}
async function propertyEarning(req,res){
    const listing = await admin_panel.propertyEarning(req,res) 
    res.json({response:listing})
}
module.exports ={
propertyBooking,
updatePropertyStatus,
userDelete,
usersList,
updateProperty,
updateUser,
editProperties,
bookingStats,
propertiesList,
getContent,
updateContent,
propertyEarning
}