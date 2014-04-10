module.exports = (router, db, passport) ->
  Controllers = {}
  require("fs").readdirSync("Controllers").forEach((file) ->
    name = file.replace('.coffee', '');
    Controllers[name] = require("./Controllers/" + name)(db, passport)                                                   
  )
  
  
  router.get '/', Controllers.base.status
  router.post '/application', Controllers.application.createApplication
  
  router.post '/login', Controllers.auth.login
  
  
  router.post '/greeter', Controllers.auth.isAuthenticated, Controllers.auth.checkRole(['admin', 'hr']), Controllers.user.create
  ###
  api.get '/', api.Controllers.base.index
  
  api.post '/login', api.Controllers.session.login
  api.get '/login', api.Controllers.session.session
  api.get '/logout', api.Controllers.session.logout

  api.post '/signup', api.Controllers.application.new
  
  api.post '/users', api.Controllers.user.create
  api.get '/users', api.Controllers.user.index
  api.get '/users/:id', api.Controllers.user.single
  ###
  
