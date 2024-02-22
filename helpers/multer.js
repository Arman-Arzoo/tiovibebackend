const multer = require('multer');
let fs = require('fs-extra');

let storage = multer.diskStorage({
destination: function (req, file, cb) {
    fs.mkdirsSync(__dirname + '/uploads/images'); // fs.mkdirsSync will create folders if it does not exist
    cb(null, __dirname + '/uploads/images');
},
filename: function (req, file, cb) {
   console.log(file);
   const ext = file.mimetype.split("/")[1];
    cb(null, `${file.originalname}.${ext}`);
 }
})

let upload = multer({ storage: storage });

let createUserImage = upload.single('file');

let multerHelper = {
    createUserImage,
}

module.exports = multerHelper;