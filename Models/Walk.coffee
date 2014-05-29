module.exports = (Sequelize, DataTypes) ->
    Walk = Sequelize.define('Walk', {
      name: {
        type: DataTypes.STRING
        validate: {
          notEmpty: false
          isAlpha: true
        }
    }
    email: {
        type: DataTypes.STRING
        validate: {
          notEmpty: false
          isEmail: true
        }
    }
    userLang: {
      type: DataTypes.STRING
      validate: {
        notEmpty: false
      }
    }
    hourFrom: {
      type: DataTypes.STRING
      validate: {
        notEmpty: false
      }
    }
    hourTo: {
      type: DataTypes.STRING
      validate: {
        notEmpty: false
      }
    }
    languages: {
      type: DataTypes.ARRAY(DataTypes.STRING)
      validate: {
        notEmpty: false
      }
    }
    dates: {
      type: DataTypes.ARRAY(DataTypes.STRING)
      validate: {
        notEmpty: false
      }
    }
    other: DataTypes.TEXT
    })
