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
      session.roles = {}
      @.roles.forEach((role)->
          if session.roles[role.role]? then session.roles[role.role].push(role.RegionId) else
            session.roles[role.role] = [role.RegionId]
        )
      session

  }, classMethods: {
    associate: (models)->
      User.hasMany(models.Role, {as: 'Roles'})  
  })