const packages_service = require('../services/hostsPackages')

async function listPackages(req,res){
    const listing = await packages_service.listPackages(req,res) 
    res.json({response:listing})
}
async function assignPackage(req,res){
    const listing = await packages_service.assignPackage(req,res) 
    res.json({response:listing})
}
async function addPackage(req,res){
    const listing = await packages_service.addPackage(req,res) 
    res.json({response:listing})
}
async function viewPackage(req,res){
    const listing = await packages_service.viewPackage(req,res) 
    res.json({response:listing})
}
async function editPackages(req,res){
    const listing = await packages_service.editPackages(req,res) 
    res.json({response:listing})
}

module.exports = {
    listPackages,
    assignPackage,
    addPackage,
    viewPackage,
    editPackages
}