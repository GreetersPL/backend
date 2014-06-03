module.exports = (db, mail) ->
  create: (req, res)->
    user = db.Models.User.build(req.body)
    password = user.generatePassword()
    user.save().success((data)->
                         console.log data
                       ).error((data)=>
                                delete data.__raw
                                res.json(data)
                              )
    
    