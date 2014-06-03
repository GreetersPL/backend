module.exports = (router, db, passport, mail) ->
  Controllers = {}
  require("fs").readdirSync("Controllers").forEach((file) ->
    name = file.replace('.coffee', '');
    Controllers[name] = require("./Controllers/" + name)(db, passport, mail)
  )


  router.get '/', Controllers.base.status
  router.post '/signup', Controllers.application.createApplication

  router.post '/login', Controllers.auth.login
  router.get '/logout', Controllers.auth.logout

  ###
  router.post '/greeter', Controllers.auth.isAuthenticated, Controllers.auth.checkRole(['hr', 'admin']), Controllers.user.create
  ###

  router.post '/walk', Controllers.walk.create
  ###
  router.get '/travel/:id/reserve', Controllers.auth.isAuthenticated, Controllers.auth.checkRole(['greeter'])

  api.get '/', api.Controllers.base.index

  api.post '/login', api.Controllers.session.login
  api.get '/login', api.Controllers.session.session
  api.get '/logout', api.Controllers.session.logout

  api.post '/signup', api.Controllers.application.new

  api.post '/users', api.Controllers.user.create
  api.get '/users', api.Controllers.user.index
  api.get '/users/:id', api.Controllers.user.single
  ###
