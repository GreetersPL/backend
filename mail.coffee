nodemailer = require("nodemailer")
config = require("./config/" + (process.env.ENV_VARIABLE || 'development')).mail


mail = nodemailer.createTransport("SMTP", {
  service: config.service,
  auth: {
    user: config.user,
    pass: config.password
  }
});

mail['passwordMail'] = (user, password, lang = 'pl')->
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


module.exports = mail