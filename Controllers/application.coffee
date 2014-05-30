module.exports = (db, passport, mail) ->
  createApplication: (req, res)->
    application = db.Models.Application.build(req.body)
    application.save().success((data)->
      res.json({application: 'create'})
      mail.signupMail(application)
    ).error((error)->
      res.json({errors: error}, 404)
    )
