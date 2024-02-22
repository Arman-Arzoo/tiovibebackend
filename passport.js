const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
require('dotenv').config();
const db = require('./services/db');
 
const opts = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_TOKEN_KEY
};
 
module.exports = passport_strategy => {
    passport_strategy.use(
    new JwtStrategy(opts, (jwt_payload, done) => {
        console.log(opts)
        const query = 'select username from users where id = ?'
        const values = [jwt_payload.user_id]
        console.log(values)
        const user = db.executeQuery(query,values)
      if (user) {
        return done(null, user);
      }
 
      return done(null, false);
    })
  );
};