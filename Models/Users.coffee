module.exports = (Sequelize, DataTypes) ->
  User = Sequelize.define('User', {
    username: {
      type: DataTypes.STRING
      unique: true
      validate: {
        notContains: 'admin'
      }
    }
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
    password: DataTypes.STRING
    salt: DataTypes.STRING
    email: {
      type: DataTypes.STRING
      unique: true
      validate: {
        isEmail: true
      }
    }
  },
  classMethods:{
    
  }
  instanceMethods: {
    generatePassword: ()->
      set = '0123456789abcdefghijklmnopqurstuvwxyzABCDEFGHIJKLMNOPQURSTUVWXYZ'
      setLenght = set.length
      password = ""
      i = 0

      while i < 8
        p = Math.floor(Math.random() * setLenght)
        password += set[p]
        i++

      bcrypt = require('bcrypt')
      salt = bcrypt.genSaltSync();
      @.salt = salt
      password_hash = bcrypt.hashSync(password, salt)
      @.password = password_hash
      return password
    toSession: () ->
      session = {}
      session.id = @.id
      session.username = @.username
      session.name = @.name
      session.lastname = @.lastname
      session

  })
  return User