module.exports = (api, passport) ->
  login: (req, res)->
    if !req.user?
      passport
        .authenticate('local', 
          (err, user, info)->
            if !user
              res.json({error: info})
            else
              req.logIn(user, (err)=>
                console.log JSON.stringify(user)
                if err? then res.json({error:{message: "Something went wrong!"}})  else
                  res.json({status: "User logged in"})
              )
        )(req, res)
    else res.json({status: "User already logged in"})
  logout: (req, res)->
    req.logout()
    res.json({status: "User logout"})

###
Check is user authenticated.
###
  isAuthenticated: (req, res, next)->
    if req.user then next() else res.json(403, {error: {message: "Need to login"}})    
  checkRole: (roles = ['greeter'], region=[0], req, res, next)->
    return (req, res, next)->
      async = require("async")
      _ = require "lodash"
      console.log _.findIndex(req.user.roles[1], "admin")
      