var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors');
var app = express();
const stripe_service = require('./services/stripe.js')
const stripe = require('stripe')(process.env.STRIPE_SECRET_KEY);
app.post("/webhook",express.raw({ type: "application/json" }),stripe_service.updatePaymentStatus);
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var bodyParser = require('body-parser');

app.use(cors())
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(bodyParser.urlencoded({extended: true,keepExtensions: true}));
app.use(bodyParser.json());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.use('/property', express.static('public/data/property'));
app.use('/profile_pic', express.static('public/data/profile_pic'));
const sessions = require('express-session');
app.use('/api', indexRouter);
app.use('/users', usersRouter);
const passport = require('passport');
const  passport_strategy  = require('./passport');
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  res.send('heello it me');
  next(createError(404));
});
const oneDay = 1000 * 60 * 60 * 24;
app.use(sessions({
  secret: "tiovibesecret",
  saveUninitialized:true,
  cookie: { maxAge: oneDay },
    resave: false
}));
passport_strategy(passport);
// database connection
 

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'production' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;
