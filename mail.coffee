nodemailer = require("nodemailer")
config = require("./config/" + (process.env.ENV_VARIABLE || 'development')).mail

mail = nodemailer.createTransport(config.service_type, {
    service: config.service,
    auth: {
      user: config.user,
      pass: config.password
    }
  });

  
mail.passwordMail = (user, password, lang = 'pl')->
    email = user.email
    username = user.username

    switch lang
      when "pl" then emailText = "Witaj! \n Twoje konto na portalu greeters.pl zostało utworzone.\nTwój login to: #{username} \nTwoje hasło to #{password} \n\n Do zobaczenia w serwisie"
      else emailText = "Witaj! \n Twoje konto na portalu greeters.pl zostało utworzone.\nTwój login to: #{username} \nTwoje hasło to #{password} \n\n Do zobaczenia w serwisie"
    mailOptions =
      from: 'nenros@gmail.com'
      to: email
      subject: 'Hello'
      text: emailText
    @.sendMail(mailOptions, (error, response)->
      console.log (error) if error
    )
  
mail.signupMail = (application, lang = 'pl')->
    switch lang
      when "pl" then emailText = "Witaj!\n Twoje zgłoszenie zostało przyjęte, niebawem ktoś się na pewno z tobą skontaktuje! \n Pozdrawiamy\nZespół Greeters Polska"
    mailOptions =
      from: 'api@greeters.pl'
      to: application.email
      subject: 'Twoje zgłoszenie do Greeters Polska'
      text: emailText
    @.sendMail(mailOptions, (error, response)->
      console.log (error) if error
    )

    email2Text = "Witaj!\n
    Wpłyneło nowe zgłoszenie na stronie Greeters.pl!\n
      Imię: #{application.name}\n
      Wiek: #{application.age}\n
      Email: #{application.email}\n
      "
    email2Text += " Zajęcie: #{
      switch application.activity
        when "pupil" then "Uczeń\n"
        when "student" then "Student\n"
        when "job" then "Pracuje\n"
    }"
    email2Text += " Źródło: #{
      switch application.source
        when "friends" then "Od znajomych\n"
        when "internet" then "Z internetu\n"
        when "contest" then "Z konkursu 'Gdański Greeter'\n"
        when "facebook" then "Z facebooka\n"
        when "other" then "Inne\n"
    }"
    email2Text += " Języki:\n"
    for langName, langLevel of application.languages

      email2Text += "\t#{langName}: #{
        switch langLevel
          when 'beg' then langLevel = "początkujący\n"
          when 'com' then langLevel = "komunikatywny\n"
          when 'ade' then langLevel = "zawansowany\n"}"
    email2Text += " Czemu: #{application.why}\n"
    email2Text += " Oczekuję: #{
      switch application.expect
        when "fun" then "Dobrej zabawy\n"
        when "people" then "Poznania nowych ludzi\n"
        when "passion" then "Rozwijania swoich pasji i zainteresowań\n"
        when "devel" then "Rozwoju osobistego, zdobycie nowych umiejętności\n"
        when "qual" then "Podniesienie swoich kwalfikacji przydatnych na rynku pracy\n"
        when "other" then "Inne\n"
    }"
    email2Text += " 3 ciekawe miejsca wraz z opisem: #{application.places}\n"
    mailOptions =
      from: config.mail_from
      to: config.mail_hr
      subject: 'Nowe zgłoszenie na stronie greeters.pl'
      text: email2Text
    @.sendMail(mailOptions, (error, response)->
      console.log (error) if error
    )
    
module.exports = mail
###
mail.passwordMail = (user, password, lang = 'pl')->
  email = user.email
  username = user.username

  switch lang
    when "pl" then emailText = "Witaj! \n Twoje konto na portalu greeters.pl zostało utworzone.\nTwój login to: #{username} \nTwoje hasło to #{password} \n\n Do zobaczenia w serwisie"
    else emailText = "Witaj! \n Twoje konto na portalu greeters.pl zostało utworzone.\nTwój login to: #{username} \nTwoje hasło to #{password} \n\n Do zobaczenia w serwisie"
  mailOptions =
    from: 'nenros@gmail.com'
    to: email
    subject: 'Hello'
    text: emailText
  @.mailer.sendMail(mailOptions, (error, response)->
    console.log (error) if error
  )

mail['signupMail'] = (application, lang = 'pl')->
  switch lang
    when "pl" then emailText = "Witaj!\n Twoje zgłoszenie zostało przyjęte, niebawem ktoś się na pewno z tobą skontaktuje! \n Pozdrawiamy\nZespół Greeters Polska"
  mailOptions =
    from: 'api@greeters.pl'
    to: application.email
    subject: 'Twoje zgłoszenie do Greeters Polska'
    text: emailText
  @.mailer.sendMail(mailOptions, (error, response)->
    console.log (error) if error
  )

  email2Text = "Witaj!\n
  Wpłyneło nowe zgłoszenie na stronie Greeters.pl!\n
    Imię: #{application.name}\n
    Wiek: #{application.age}\n
    Email: #{application.email}\n
    "
  email2Text += " Zajęcie: #{
    switch application.activity
      when "pupil" then "Uczeń\n"
      when "student" then "Student\n"
      when "job" then "Pracuje\n"
  }"
  email2Text += " Źródło: #{
    switch application.source
      when "friends" then "Od znajomych\n"
      when "internet" then "Z internetu\n"
      when "contest" then "Z konkursu 'Gdański Greeter'\n"
      when "facebook" then "Z facebooka\n"
      when "other" then "Inne\n"
  }"
  email2Text += " Języki:\n"
  for langName, langLevel of application.languages

    email2Text += "\t#{langName}: #{
      switch langLevel
        when 'beg' then langLevel = "początkujący\n"
        when 'com' then langLevel = "komunikatywny\n"
        when 'ade' then langLevel = "zawansowany\n"}"
  email2Text += " Czemu: #{application.why}\n"
  email2Text += " Oczekuję: #{
    switch application.expect
      when "fun" then "Dobrej zabawy\n"
      when "people" then "Poznania nowych ludzi\n"
      when "passion" then "Rozwijania swoich pasji i zainteresowań\n"
      when "devel" then "Rozwoju osobistego, zdobycie nowych umiejętności\n"
      when "qual" then "Podniesienie swoich kwalfikacji przydatnych na rynku pracy\n"
      when "other" then "Inne\n"
  }"
  email2Text += " 3 ciekawe miejsca wraz z opisem: #{application.places}\n"
  mailOptions =
    from: 'api@greeters.pl'
    to: 'it@greeters.pl'
    subject: 'Twoje zgłoszenie do Greeters Polska'
    text: emailText
  @.mailer.sendMail(mailOptions, (error, response)->
    console.log (error) if error
  )

###
