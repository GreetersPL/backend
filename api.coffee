express = require('express')
http = require('http')
path = require('path')
session = require('express-session')
logger = require('morgan')
favicon = require('static-favicon')
cookieparser = require('cookie-parser')
corser = require('corser')

RedisStore = require('connect-redis')(session)

api = express()

api.config = require("./config/" + (process.env.NODE_ENV || 'development'))


api.set('port', api.config.app.port)

if api.config.app.logger.dev? && api.config.app.logger.dev is false 
  api.use(logger())
else
  api.use(logger('dev'))
  
api.use(require('body-parser')());
api.use(require('method-override')())
api.use(require('connect-multiparty')())
api.use(cookieparser('razdwa'));
api.use(session(store: new RedisStore))
api.use(require('errorhandler')())

api.use((err, req, res, next)->
  if !err then next();
  res.json("Error");
)

api.use(corser.create())

api.db = require('./libs/db')(api.config.db)
api.passport = require('./libs/authentication')(api.db)
api.mail = require('./libs/mail')(api.config.mail)

api.use(api.passport.initialize())
api.use(api.passport.session())

router = require('./router')(express.Router(), api.db, api.passport)
api.use(router)

http.createServer(api).listen(api.get('port'), api.config.app.ip || '0.0.0.0', ->
  console.log("Express server listening on port " + api.get('port'))
)
