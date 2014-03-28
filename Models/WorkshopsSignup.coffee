module.exports = (Sequelize, DataTypes) ->
  WorkshopSignup = Sequelize.define('WorkshopSignup',{
      name:
        type: DataTypes.STRING
        validate:
          isAlpha: true
          notEmpty: true
      email:
        type: DataTypes.STRING
        validate:
          isEmail: true
          notEmpty: true
      phone: DataTypes.STRING
      code: DataTypes.STRING
      status: 
        type: DataTypes.ENUM
        values: ['pending', 'active']
        defaultValue: 'pending'
    }, {
      instanceMethods:
        createCode: ()->
          set = '0123456789abcdefghijklmnopqurstuvwxyzABCDEFGHIJKLMNOPQURSTUVWXYZ'
          setLenght = 8
          code = ""
          i = 0

          while i < 8
            p = Math.floor(Math.random() * setLenght)
            code += set[p]
            i++
          @.code = code
        confirm: ()->
          @.status = 'active'
      classMethods:
        associate: (models)->
          WorkshopSignup.belongsTo(models.WorkshopClass, {as: 'Class'})
    })
  