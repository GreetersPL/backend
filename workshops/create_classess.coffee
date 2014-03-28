app = {}
app.db = require '../db'

app.i = 0

app.classes = {
  'Praca z ciałem i ruchem': {
    'Kinga Szołczyńska': [
      {
        title: '„I like to move it!” - otwórz się!'
        about: 'Pod tym tajemniczym tytułem kryją się zagadkowe zajęcia o których nie zdradzimy za wiele – tylko dla odważnych albo tych, którzy odwagę chcą w sobie odnaleźć i pozwolić sobie na odrobinę szaleństwa ;-)  Uchylając jedynie rąbka tajemnicy powiedzmy, że są to zajęcia ruchowe, nie wymagające jednak  kondycji fizycznej i specjalnych predyspozycji. Spróbujemy lepiej poznać swoje ciało i to co ono do nas i o nas mówi.'
        begin: '04-04-2014 18:00'
        end: '04-04-2014 19:30'
        limit: 20
      }
    ]
    'Angelika Gałązka': [
      {
        title: 'Salsa'
        about: 'Salsa to gorący taniec w latynoskich rytmach. Jeśli chcecie tego posmakować pod okiem profesjonalnej instruktorki – zapraszamy!'
        begin: '04-04-2014 19:45'
        end: '04-04-2014 20:45'
        limit: 20
      }
    ]
  }
  'Rozwój osobisty':
    'Kinga Szołczyńska': [
      {
        title: 'Cukier, słodkości i różne śliczności” - 3 magiczne składniki bez których nie zmotywujesz (się) skutecznie'
        about: '„Żeby mi się tak chciało jak mi się nie chce...” Ile razy  w swoim życiu pomyślełeś/aś lub powiedziałeś/aś te słowa? A czy przyszło Ci kiedyś przez myśl dlaczego właściwie jednych rzeczy nam się chce, a innych zupełnie nie? Dlaczego czasem energia do działania aż nas rozpiera a innym razem robilibyśmy wszystko tylko nie to co powinniśmy? Na te pytania odpowiemy sobie podczas tego warsztatu. I będziemy działać. Ze sporym powerem ;-)'
        begin: '04-05-2014 11:45'
        end: '04-05-2014 13:15'
        limit: 20
      }
    ]
    'brak': [
      {
        title: 'Zarządzanie własnym czasem'
        about: 'Znowu spóźnienie? Lista rzeczy do zrobienia nie ma końca? Dzisiaj obiecujesz sobie zrobić wszystko, co miało być zrobione na wczoraj i tydzień temu? Jeśli tak wygląda Twoja rzeczywistość, ten warsztat jest właśnie dla Ciebie! Wspólnie zastanowimy się ja sobie radzić z tym, że doba ma tylko 24h :-)'
        begin: '04-05-2014 10:00'
        end: '04-05-2014 11:30'
        limit: 20
      }
    ]
  'Rozwój kompetencji w relacjach':
    'Kinga Szołczyńska': [
      {
        title: 'Role grupowe i komunikacja'
        about: 'Lider, doradca, aktywista? Dobry duch czy błazen? Kim jesteś? Jakie role pełnisz w grupach, do których trafiasz? Czy robisz to świadomie, czy po prostu tak się dzieje? Jak się w tych rolach czujesz? Rzecz będzie więc o tym, co się dzieje, gdy więcej niż dwóch ludzi spotka się by działać wspólnie. I o tym jak im się będzie rozmawiało. I czy da się robić to lepiej i efektywniej :-)'
        begin: '04-05-2014 14:00'
        end: '04-05-2014 16:00'
        limit: 20
      }
    ]
    'brak': [
      {
        title: '„Wodzu, co mamy robić?” Czyli doskonalenie warsztatu lidera – zarządzanie grupą, style dowodzenia '
        about: 'Zajęcia dla tych, którzy dowodzą, dowodzić chcą lub dowodzić nie potrafią – a nauczyć się byłoby dobrze :-) Jak stać na czele, a się nie rządzić, jak być pierwszym w grupie, a nie ponad grupą.'
        begin: '04-05-2014 16:15'
        end: '04-05-2014 18:00'
        limit: 20
      }
    ]
  'Metody organizacji pracy':
    'Marcin Olszewski': [
      {
        title: 'Od pomysłu do projektu, czyli jak nie chować swoich pomysłów do szuflady.'
        about: 'W najbardziej niespodziewanym momencie do głowy przychodzą nam najlepsze pomysły. Niewiele z nich doczeka się jednak realizacji. Zwiększ swoje szanse i poznaj w praktyce, jak zamienić pomysł na projekt.'
        begin: '04-06-2014 16:45'
        end: '04-06-2014 18:15'
        limit: 20
      }
    ]
    'brak': [
      {
        title: 'jak dostosować metodyki(modele) pracy z konkretnych dziedzin(np. z informatyki) do ogólnych zagadnień'
        about: 'Przekonasz się o ile przyjemniejsza i łatwiejsza jest praca w dobrze zorganizowanym zespole. A co mają do tego klocki LEGO? Sprawdź!'
        begin: '04-06-2014 15:00'
        end: '04-06-2014 16:30'
        limit: 20
      }
    ]
}

app.db.sequelize.sync().success(()->
  for block_name, val of app.classes
    app.db.Models.WorkshopBlock.find({where: {name: block_name}}).success((block)->
      return if !block?
      for leader_name of app.classes[block.name]
        if leader_name is 'brak'
          for clas in app.classes[block.name][leader_name]
            app.db.Models.WorkshopClass.create(clas).success((clas)->
              clas.setBlock(block)
            )
        else
          app.db.Models.WorkshopLeader.find({where: {name: leader_name}}).success((leader)->
            return if !leader?
            for clas in app.classes[block.name][leader.name]
              app.db.Models.WorkshopClass.create(clas).success((clas)->
                clas.setLeader(leader).success((data)->
                  clas.setBlock(block)
                )
              )
          )
    )
)
return