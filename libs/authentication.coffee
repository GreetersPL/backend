passport = require('passport');
LocalStrategy = require('passport-local').Strategy

module.exports = (db) ->
  User = db.Models.User
  passport.serializeUser((user, done)->)
  passport.deserializeUser((id, done)->)
  passport.use(new LocalStrategy({usernameField : 'email', passwordField : 'password', passReqToCallback : true},
    (req, email, password, done)->
      User.find(where: {email: email}).success((user)->
        if !user?
          done(null, false, {message: "User not found"})
        else if user.password isnt password
          done(null, false, "Wrong password")  
      )
  ))
  passport