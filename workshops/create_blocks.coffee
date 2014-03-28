app = {}
app.db = require '../db'
Q = require 'q'
deferred = Q.defer()
app.i = 0
app.blocks = [
  {
    place: 'AWFIS'
    name: 'Praca z ciałem i ruchem'
    date: '04.04.2014'
  }
  {
    place: 'WNS UG'
    name: 'Rozwój osobisty'
    date: '05.04.2014'
  }
  {
    place: 'WNS UG'
    name: 'Rozwój kompetencji w relacjach'
    date: '05.04.2014'
  }
  {
    place: 'PG'
    name: 'Metody organizacji pracy'
    date: '06.04.2014'
  }
]

app.db.sequelize.sync().success(()->
  app.db.Models.Workshop.find(where : {start: '2014-04-04'}).success((workshop)->                                                                    
    for block in app.blocks
      block = app.db.Models.WorkshopBlock.create(block).success((block)->                                                                      
        workshop.addBlock(block).success((block)->
          app.i++                                      
          return deferred.resolve() if app.i is app.blocks.length - 1
      )                                       
    )
  )
)

module.exports = deferred.promise;