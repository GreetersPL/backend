module.exports = (api) ->
  
  api.get '/', api.Controllers.base.index

  api.post '/login', api.Controllers.session.login
  api.get '/login', api.Controllers.session.session
  
  api.post '/users', api.Controllers.user.create
  api.get '/users', api.Controllers.user.index
  api.get '/users/:id', api.Controllers.user.single

