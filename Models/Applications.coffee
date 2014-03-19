module.exports = (Sequelize, DataTypes) ->
    Application = Sequelize.define('Application', {
        name: {
            type: DataTypes.STRING
            validate: {
              notEmpty: false
              isAlpha: true
            }
        }
        age: {
            type: DataTypes.INTEGER
            validate: {
              notEmpty: false
              isNumeric: true
            }
        }
        email: {
            type: DataTypes.STRING
            unique: true
            validate: {
              notEmpty: false
              isEmail: true
            }
        }
        activity: {
            type: DataTypes.ENUM
            values: ['pupil', 'student', 'job']
        } 
        source: {
            type: DataTypes.ENUM
            values: ['friends', 'internet', 'contest', 'facebook', 'other']
        }
        languages: {
          type: DataTypes.STRING
          validate: {
            notEmpty: false
          }
          set: (langs)->
            if langs? is true then @.setDataValue('languages', JSON.stringify(langs)) else @.setDataValue('languages', null) 
          get: ()->
            langs = @.getDataValue('languages')
            JSON.parse(langs)
        }
        why: {
          type: DataTypes.TEXT
          validate: {
            notEmpty: false           
          }           
        }
        places: {
           type: DataTypes.TEXT
           validate: {
            notEmpty: false           
          }   
        }
    })