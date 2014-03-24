module.exports = (api) ->
  api.post '/signup', (req, res)->
    application = api.db.Models.Application.build(req.body)

    application.save().success((data)->
      res.json({application: 'create'})
      api.mail.signupMail(application)
    ).error((error)->
      res.json({errors: error}, 404)
    )
  