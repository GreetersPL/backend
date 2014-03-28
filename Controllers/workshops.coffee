module.exports = (api) ->
	api.get '/workshops', (req, res)->
    	api.db.redis.get('workshop', (err, workshop)->
     		res.json JSON.parse(workshop)
    	)
  api.post '/workshops/confirm', (req, res)->
    	api.db.Models.WorkshopSignup.find(where: {code: req.body.code}).success((signup)->
        if !signup?
          return res.json(404, {error: 'no code'})
        api.db.Models.WorkshopSignup.findAndCountAll({where: {WorkshopClassID: signup.WorkshopClassID, status: 'active'}}).success((result)->
          if result.count >= 20
            res.json(404, {error: 'limit'})
          signup.confirm()
          res.json({status: 'success'})
        )
      )	
  api.post '/workshops/:id', (req, res)->
    	signup = api.db.Models.WorkshopSignup.build(req.body)
    	signup.WorkshopClassId = req.params.id
    	signup.createCode()
    	signup.save().success((data)->
    		res.json {status: 'success'}
    		api.mail.workshopCode(data)

    	).error((data)-> 
    		res.json(404, {error: data})
    	)
    