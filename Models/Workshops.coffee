Q = require 'q'
_ = require 'lodash'
moment = require 'moment'
module.exports = (Sequelize, DataTypes) ->
  Workshop = Sequelize.define('Workshop',{
    start: 
      type: DataTypes.DATE
      get: ()->
        moment(@.getDataValue('start')).format('DD-MM-YYYY')
    end: 
      type: DataTypes.DATE
      get: ()->
        moment(@.getDataValue('end')).format('DD-MM-YYYY')
    active: DataTypes.BOOLEAN
  },{
    instanceMethods:
      createCache: (Models)->
        deferred = Q.defer()
        json = {
          workshops: [{
            id: @.id
            start: @.start
            end: @.end
            blocks: []
          }]
          blocks: [
          ]
          leaders: [
          ]
          classes: [
          ]
        }
        workshop_id = _.findIndex(json.workshops, {id: @.id})
        blocks = @.getBlock()
        blocks.then((blocks)->
          blocks.forEach((block)->

            json.workshops[workshop_id].blocks.push block.id
            block_json = {
              id: block.id
              name: block.name
              place: block.place
              date: block.date
              classes: []
            }

            json.blocks.push block_json
          )
          blocks
        ).then(()->
          Models.WorkshopClass.findAll({WorkshopBlockId: json.workshops[workshop_id].blocks}).success((classes)->
            classes.forEach((clas)->
              class_json = {
                id: clas.id
                title: clas.title
                about: clas.about
                leader: clas.WorkshopLeaderId
                block: clas.WorkshopBlockId
                begin: clas.begin
                end: clas.end
              }
              json.classes.push class_json
              block_array_position = _.findIndex(json.blocks, {id: clas.WorkshopBlockId})
              json.blocks[block_array_position].classes.push clas.id
            )
          ).then((data)->
            leaders_id = {}
            json.classes.forEach((clas)->
                
                if leaders_id[clas.leader]? and clas.leader?
                  leaders_id[clas.leader].push clas.id
                else if clas.leader?
                  leaders_id[clas.leader] = [clas.id]
                
            )
            Models.WorkshopLeader.findAll({where: {id: _.keys(leaders_id)}}).success((leaders)->                                                                                    
              leaders.forEach((leader)->                              
                leader_json = {
                  id: leader.id
                  name: leader.name
                  about: leader.about
                  classes: leaders_id[leader.id]
                }
                json.leaders.push leader_json              
              )                                                                          
                       
            ).then(()->deferred.resolve json)
          )
        )
        deferred.promise
    classMethods:
      associate: (models)->
        Workshop.hasMany(models.WorkshopBlock, {as: 'Block'})
  })

