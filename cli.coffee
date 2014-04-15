opts = require('nomnom')
config = require("./config/" + (process.env.NODE_ENV || 'development'))
db = require('./libs/db')(config.db)
mail = require('./libs/mail')(config.mail)
async = require 'async'


opts.command('user-add')
  .callback((options)->
      user = {
        email: options.email
        name: options.name
        lastname: options.lastname
        username: options.username
      }
      user = db.Models.User.build(user)
      password = user.generatePassword()
      user.save().then(((data)-> 
          console.log "User created successful"
          mail.passwordMail(data, password, 'pl', process.exit(code=0))
        ), (data)-> 
          if data.code is  "ER_DUP_ENTRY"
            console.log "Email #{user.email} or username #{user.username} exist in db"
          process.exit(code=1)
        )
      
    )
  .option('email',{
      abbr: 'e'
      help: "Email"
      required: true
    })
  .option('username',{
      abbr: 'u'
      help: "Usernam"
      required: true
    })
  .option('name',{
      abbr: 'n'
      help: "First name"
      required: true
    })
  .option('lastname',{
      abbr: 'l'
      help: "Last name"
      required: true
    })

opts.command('user-remove')
  .callback((options)->
    db.Models.User.find(where: {email: options.email}).success((user)->
      if user?
        user.destroy().success(()->
          console.log "User #{options.email} deleted"
          process.exit(code=0)
        )
      else
        console.log "No such user like #{options.email}"
        process.exit(code=1)
      )
    )
  .option('email', {
      abbr: "e"
      help: "Email"
      required: true
    })

opts.command('user-add-role')
  .callback((options)->
    db.Models.User.find(where: {username: options.user}).success((user)->
        if !user?
          console.log "No such user"
          process.exit(code=1)
        role = db.Models.Role.build({
          role: options.role
          RegionId: options.region
          UserId: user.id
          })
        role.save().then((data)->
            console.log "Role #{options.role} added to user #{user.name} #{user.lastname}"
            process.exit(code=0)
          )
      )
    )
  .option('user',{
      abbr: 'u'
      help: "User username"
      required: true
    })
  .option('role', {
    abbr: 'r'
    help: "User role"
    choices: ['greeter', 'pr', 'hr', 'admin']
    required: true
    })
  .option('region', {
    abbr: 'g'
    help: 'Region'
    required: true
    })

opts.command('region-add')
  .callback((options)->
    region = {
      city: options.city
      shortname: options.shortname
    }

    region = db.Models.Region.build region
    region.save().then(((data)->
        console.log "City saved successful"
        process.exit(code=0)
      ), (data)->
        if data.code is "ER_DUP_ENTRY"
          console.log "#{region.shortname} already exist"
          process.exit(code=1)
      )

  )
  .option('city', {
    abbr: 'c'
    help: 'City name'
    required: true
  })
  .option('shortname', {
    abbr: 's'
    help: "City shortname"
    required: true
  })

opts.command('region-list')
  .callback(()->
      db.Models.Region.findAll().success((regions)->
        console.log "ID | City"
        regions.forEach((region)->
            console.log "#{region.id}: #{region.city}"
          )
        process.exit(code=0)
        )
    )
  
  
opts.parse()