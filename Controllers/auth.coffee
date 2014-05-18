_ = require "lodash"
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

  isAuthenticated: (req, res, next)->
    if req.user then next() else res.json(401, {error: {message: "Need to login"}})
      
  checkRole: (roles = ['greeter'], req, res, next)->
    return (req, res, next)->
      region = req.body.region | 1
      for role, i in roles
        if _.contains(req.user.roles[role], region) then next() else
          if i  == (roles.length-1) then res.json(403, {error: {message: "Insufficient permissions"}})