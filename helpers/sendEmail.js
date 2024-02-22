const nodemailer = require('nodemailer');
const transporter = nodemailer.createTransport({
    host: 'smtp.gmail.com',
    port: 587,
    auth: {
        user: 'mohsin70009@gmail.com',
        pass: 'bhwcxoeypwozzqqz'
    }
});

// send email
async function sendMail(to,from,msg,subject){
    await transporter.sendMail({
        from: '',
        to: to,
        subject: subject,
        html: msg,
    });
    return true
}
module.exports = {
    sendMail
}
