Sequelize = require('sequelize')

redis = require('redis')
client = redis.createClient()
module.exports = (config)->
  db = {}
  db.Models = {}

  sequelize = new Sequelize(config.db_name, config.username, config.password || null, {dialect: config.dialect})
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