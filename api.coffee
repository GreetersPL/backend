express = require('express')
http = require('http')
path = require('path')
session = require('express-session')
logger = require('morgan')
bodyParser = require('body-parser')
favicon = require('static-favicon')
cookieparser = require('cookie-parser')
corser = require('corser')

RedisStore = require('connect-redis')(session)

api = express()

api.config = require("./config/" + (process.env.ENV_VARIABLE || 'development'))

api.set('port', api.config.app.port)
api.use(logger('dev'))
api.use(bodyParser())
api.use(cookieparser('razdwa'));
api.use(session(store: new RedisStore))
###  
api.use(express.errorHandler()) if config.errorHandler? && config.errorHandler
####

api.use(corser.create())

api.db = require('./db')
api.mail = require('./mail')
console.log api.mail
require('./router')(api)

  
http.createServer(api).listen(api.get('port'), ->
  console.log("Express server listening on port " + api.get('port'))
)
