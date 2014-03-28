app = {}
app.db = require '../db'
Q = require 'q'
deferred = Q.defer()
app.workshops = {
  start: '04.04.2014'
  end: '06.04.2014'               
}

app.db.sequelize.sync().success(()->

  workshop = app.db.Models.Workshop.build(app.workshops)
  workshop.save().success((workshop)-> deferred.resolve(workshop))
                                  
                                
)
module.exports = deferred.promise;