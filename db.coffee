Sequelize = require('sequelize-mysql').sequelize
mysql     = require('sequelize-mysql').mysql
config = require("./config/" + (process.env.ENV_VARIABLE || 'development')).db

db = {}
db.Models = {}

sequelize = new Sequelize(config.db_name, config.username, config.password, {
    dialect: config.dialect
  })
require("fs").readdirSync('./Models').forEach((Model)->
  model = sequelize.import('./Models/' + Model)
  db.Models[model.name] = model                                                
)
  
Object.keys(db.Models).forEach((modelName) ->
  db.Models[modelName].options.associate(db.Models) if db.Models[modelName].options.hasOwnProperty('associate') 
)
sequelize.sync().success((success)->
  console.log('DB synced')
).error((error)->
  console.log(error)
)
db.sequelize = sequelize
  
module.exports = db
  
  