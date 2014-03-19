module.exports = (api) ->
  require("fs").readdirSync("./Controllers").forEach((file) ->
    name = file.replace('.coffee', '');
    require("./Controllers/" + name)(api)
  )
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
  
