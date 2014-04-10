module.exports = (api, passport) ->
  login: (req, res)->
    passport
      .authenticate('local', 
        (err, user, info)->
          if !user
            res.json({error: info})
        )(req, res)
  logout: (req, res)->
  isAuthenticated: (req, res, next)->
    if req.user then next() else res.json(403, {error: {message: "Need to login"}})    
  checkRole: (roles = ['greeter'], region=[0], req, res, next)->
    return (req, res, next)->
      async = require("async")
      