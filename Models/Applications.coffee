module.exports = (Sequelize, DataTypes) ->
    Application = Sequelize.define('Application', {
        name: {
            type: DataTypes.STRING
            validate: {
                isAlpha: true
            }
        }
        lastname: {
            type: DataTypes.STRING
            validate: {
              isAlpha: true
            }
        }
        age: {
            type: DataTypes.INTEGER
            validate: {
                isNumeric: true
            }
        }
        email: {
            type: DataTypes.STRING
            unique: true
            validate: {
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
    })