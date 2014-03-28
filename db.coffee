Sequelize = require('sequelize-mysql').sequelize
mysql     = require('sequelize-mysql').mysql
config = require("./config/" + (process.env.NODE_ENV || 'development')).db
redis = require('redis')
client = redis.createClient()

db = {}
db.Models = {}

sequelize = new Sequelize(config.db_name, config.username, config.password || null)
require("fs").readdirSync('./Models').forEach((Model)->
  model = sequelize.import('./Models/' + Model)
  db.Models[model.name] = model                                                
)

for modelName of db.Models  
  db.Models[modelName].associate(db.Models) if db.Models[modelName].associate?
sequelize.sync().success((success)->
  console.log('DB synced')
  console.log('Creating redis cache')
  console.log('Loading workshops')
  workshops_json = []                         
  db.Models.Workshop.findAll().success((workshops)->
    return if !workshops?                                        
    workshops.forEach((workshop)->
      workshop = workshop.createCache(db.Models)
      workshop.then((data)->
        data = JSON.stringify data
        client.set("workshop", data, redis.print)            
      )                     
    )
  )                         
                         
                           
).error((error)->
  console.log(error)
)
db.sequelize = sequelize
db.redis = client
  
module.exports = db
  
  