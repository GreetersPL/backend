app = {}
app.db = require '../db'
Q = require 'q'
deferred = Q.defer()
app.i = 0

app.leaders = [
  {
    name: 'Kinga Szołczyńska'
    about: 'Studentka psychologii, animatorka zabaw dla dzieci, członek zespołu trenerskiego w ZHP; chce pomagać ludziom odkrywać ich potencjał :-), tańczy z zamiłowania'
  }
  {
    name: 'Marcin Olszewski'
    about: 'Student informatyki, programista'
  }
  {
    name: 'Angelika Gałązka'
    about: 'Instruktorka Salsy ze Szkoły Tańca Dance Fusion '
  }
]

app.db.sequelize.sync().success(()->
  for leader in app.leaders
    app.db.Models.WorkshopLeader.create(leader).success((data)-> deferred.resolve() if app.i is app.leaders.length - 1)
)    
module.exports = deferred.promise;