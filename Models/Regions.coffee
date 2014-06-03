module.exports = (Sequelize, DataTypes) ->
	Region =  Sequelize.define('Region', {
			city: DataTypes.STRING
			shortname: {
				type: DataTypes.STRING
				unique: true
			}
		},
  			classMethods: {
  				associate: (models)->
  					Region.hasMany(models.Role, {as: 'Team'})	
  			}
		)
