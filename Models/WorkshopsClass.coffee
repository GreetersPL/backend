moment = require 'moment'
module.exports = (Sequelize, DataTypes) ->
  WorkshopClass = Sequelize.define('WorkshopClass',{
      title: DataTypes.STRING
      about: DataTypes.TEXT
      begin: 
        type: DataTypes.DATE
        get: ()->
          moment(@.getDataValue('begin')).format('MM/DD/YYYY, HH:mm')
      end: 
        type: DataTypes.DATE
        get: ()->
          moment(@.getDataValue('end')).format('MM/DD/YYYY, HH:mm')
      limit: DataTypes.INTEGER
    }, {
      instanceMethods:
        checkLimit: ()->
          
      classMethods:
        associate: (models)->
          WorkshopClass.belongsTo(models.WorkshopLeader, {as: 'Leader'})
          WorkshopClass.belongsTo(models.WorkshopBlock, {as: 'Block'})
          WorkshopClass.hasMany(models.WorkshopSignup, {as: 'Signups'})
    })
  