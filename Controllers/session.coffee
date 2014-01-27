exports.login = (req, res) ->
  db = require('../db')
  bcrypt = require('bcrypt')
  db.Models.User.find(
    where:
      username: req.body.username
  ).success((user)->
    if user?
      bcrypt.compare(req.body.password, user.password, (err, same)->
        if err?
          res.json(err)
        else if same
          delete user.password
          console.log(user.password)
          req.session.user = user.toSession()

          res.json([{
            status: "Logged"
            msg: "Hello #{user.name} #{user.lastname}"
          }])
        else
          res.json([{
            error: 'Wrong password'
          }])
      )
    else
      res.json([error: 'No such user.'])
  ).error((error)->
    res.json(error)
  )

exports.logout = (req, res) ->
exports.session = (req, res) ->
  console.log(req.session.user)
  if req.session.user?
    res.json([user: req.session.user])
  else
    res.json([err: 'Not logged'])
