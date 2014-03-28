moment = require 'moment'
module.exports = (Sequelize, DataTypes) ->
  WorkshopBlock = Sequelize.define('WorkshopBlock',{
      name: DataTypes.STRING
      place: DataTypes.STRING
      date: 
        type: DataTypes.DATE
        get: ()->
          moment(@.getDataValue('date')).format('DD-MM-YYYY')
    }, {
      classMethods:
        associate: (models)->
          WorkshopBlock.hasMany(models.WorkshopClass, {as: 'Class'})
          WorkshopBlock.belongsTo(models.Workshop, {as: 'Workshop'})
    })
  
