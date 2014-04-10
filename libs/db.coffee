Sequelize = require('sequelize-mysql').sequelize
mysql     = require('sequelize-mysql').mysql
redis = require('redis')
client = redis.createClient()
module.exports = (config)->
  db = {}
  db.Models = {}

  sequelize = new Sequelize(config.db_name, config.username, config.password || null)
  require("fs").readdirSync('./Models').forEach((Model)->
    model = sequelize.import('../Models/' + Model)
    db.Models[model.name] = model                                                
  )

  for modelName of db.Models  
    db.Models[modelName].associate(db.Models) if db.Models[modelName].associate?
  sequelize.sync().success((success)->                  
  ).error((error)->
    console.log(error)
  )
  db.sequelize = sequelize
  db.redis = client
  db 