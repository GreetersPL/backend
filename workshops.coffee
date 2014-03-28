workshops = require './workshops/create_workshops'
workshops.then((data)->        
  blocks = require('./workshops/create_blocks')
  blocks.then((data)->        
    leaders = require('./workshops/create_leaders')
    
    leaders.then(data).then((data)->
      require('./workshops/create_classess')
    )              
  )
)
