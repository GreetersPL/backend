module.exports = (db, passport, mail) ->
  create: (req, res)->
    walk = {
      name: req.body.name
      email: req.body.email
      hourFrom: req.body.hourFrom
      hourTo: req.body.hourTo
      userLang: req.body.userLang
      languages: []
      dates: []
      other: req.body.other
    }
    if req.body.languages?
      languages = req.body.languages.split(',')
      languages.forEach((lang)->
          walk.languages.push(lang)
        )
    if req.body.dates?
      dates = req.body.dates.split(',')
      dates.forEach((date)->
          walk.dates.push(date)
        )
    walk = db.Models.Walk.build(walk)
    walk.save().success((walk)=>
        res.json({walk: 'created'})
        mail.newWalk(walk)
      ).error((error)=>
        console.log error
        res.json(400, {walk: 'error'})
      )
