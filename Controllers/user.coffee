db = require('../db')
mail = require('../mail')
helpers = require('../helpers')

exports.create = (req, res)->
  post_user = req.body.user
  user = db.Models.User.build(
    name: post_user.name
    lastname: post_user.lastname
    email: post_user.email
    username: post_user.username
    region: post_user.region
  )

  password = user.generatePassword()

  user.save().success(()->
    mail.passwordMail(user, password)
    res.json([user: user])
  ).error((error)->
    res.json(error)
  )

exports.index = (req, res) ->
  role = helpers.authenticate(req) 
  if role is false then res.json(msg: 'Authenticate first') else
    where = req.query || {}
    db.Models.User.findAll({where: where}).success((users)->
      res.json(users: users)
    ).error((error)->
      res.json(error)
    )

exports.single = (req, res) ->
  db.Models.User.find(req.params.id).success((user)->
    res.json user: user
  ).error((error)->
    res.json error
  )

  
  