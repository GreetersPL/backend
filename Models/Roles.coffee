module.exports = (Sequelize, DataTypes) ->
  Role =  Sequelize.define('Role', {
  		role: DataTypes.ENUM('greeter', 'hr', 'pr', 'admin')
  	},
  	classMethods: {
  		associate: (models)->
  			Role.belongsTo(models.Region, {as: 'Region'})	
  			Role.belongsTo(models.User, {as: 'User'})
  	})