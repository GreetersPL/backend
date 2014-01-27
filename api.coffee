express = require('express')
http = require('http')
path = require('path')

config = require("./config/" + (process.env.ENV_VARIABLE || 'development')).app

api = express()


api.set('port', config.port)
api.use(express.logger('dev'))
api.use(express.json());
api.use(express.urlencoded());
api.use(express.multipart())
api.use(express.methodOverride())
api.use(express.cookieParser());
api.use(express.session({secret: config.session.cookieSecret})) if config.session.cookieSecret?
api.use(express.errorHandler()) if config.errorHandler? && config.errorHandler

              
api.Controllers = {}
require("fs").readdirSync("./Controllers").forEach((file) ->
  name = file.replace('.coffee', '');
  api.Controllers[name] = require("./Controllers/" + name)
)
  
require('./router')(api)

  
http.createServer(api).listen(api.get('port'), ->
  console.log("Express server listening on port " + api.get('port'))
)
