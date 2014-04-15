passport = require('passport');
bcrypt = require 'bcrypt'
LocalStrategy = require('passport-local').Strategy

module.exports = (db) ->
  User = db.Models.User
  passport.serializeUser((user, done)->
    done(null, user.toSession())
  )
  passport.deserializeUser((user, done)->
    done(null, user)  
  )
  passport.use(new LocalStrategy({usernameField : 'email', passwordField : 'password', passReqToCallback : true},
    (req, email, password, done)->
      User.find(where: {email: email}, include: [{model: db.Models.Role, as: "Roles"}]).success((user)->
        if !user?
          done(null, false, {message: "User not found"})
        else if bcrypt.compareSync(password, user.password)
          done(null, false, "Wrong password")
        else 
          done(null, user, "User logged in")  
      )
  ))
  passport