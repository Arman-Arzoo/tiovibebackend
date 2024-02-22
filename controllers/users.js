const userService = require('../services/userService')

async function signUp(req,res){
    const create_user = await userService.signupService(req,res) 
    res.json({response:create_user})
}
async function confirmMail(req,res){
    const confirm_user = await userService.confirmMail(req,res) 
    res.json({response:confirm_user})
}
async function signIn(req,res){
    const sign_user = await userService.signIn(req,res) 
    res.json({response:sign_user})
}
async function setUpProfile(req,res){
    const sign_user = await userService.setUpProfile(req,res) 
    res.json({response:sign_user})
}
async function initiateResetPassword(req,res){
    const sign_user = await userService.initiateResetPassword(req,res) 
    res.json({response:sign_user})
}
async function resetPassword(req,res){
    const sign_user = await userService.resetPassword(req,res) 
    res.json({response:sign_user})
}
async function confirmResetPassword(req,res){
    const sign_user = await userService.confirmResetPassword(req,res) 
    res.json({response:sign_user})
}
async function verifyGoogleToken(req,res){
    const sign_user = await userService.verifyGoogleToken(req,res) 
    res.json({response:sign_user})
}
async function userDetail(req,res){
    const sign_user = await userService.userDetail(req,res) 
    res.json({response:sign_user})
}
async function userStatus(req,res){
    const sign_user = await userService.userStatus(req,res) 
    res.json({response:sign_user})
}
module.exports = {
    signUp,
    confirmMail,
    signIn,
    setUpProfile,
    initiateResetPassword,
    resetPassword,
    confirmResetPassword,
    verifyGoogleToken,
    userDetail,
    userStatus
}