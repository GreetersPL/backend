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

api.config = require("./config/" + (process.env.NODE_ENV || 'development'))


api.set('port', api.config.app.port)

if api.config.app.logger.dev? && api.config.app.logger.dev is false 
  logfile = require('fs').createWriteStream(api.config.app.logger.filename, {flags: 'a'})
  api.use(logger(stream: logfile))
else
  api.use(logger('dev'))
  
api.use(bodyParser())
api.use(cookieparser('razdwa'));
api.use(session(store: new RedisStore))
api.use(require('errorhandler')())

api.use((err, req, res, next)->
  if !err then next();
  res.json("Error");
)

api.use(corser.create())

api.db = require('./db')
api.mail = require('./mail')

require('./router')(api)

  
http.createServer(api).listen(api.get('port'), ->
  console.log("Express server listening on port " + api.get('port'))
)
