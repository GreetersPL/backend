module.exports = (Sequelize, DataTypes) ->
  WorkshopLeader = Sequelize.define('WorkshopLeader',{
      name: DataTypes.STRING
      about: DataTypes.TEXT
    }, {
      classMethods:
        associate: (models)->
          WorkshopLeader.hasMany(models.WorkshopClass, {as: 'Class'})
    })
  