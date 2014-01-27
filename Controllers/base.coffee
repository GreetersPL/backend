db = require('../db')
exports.index = (req, res)->
    response = []
    text = {status: "ok"}
    response.push(text)
    res.json(response)
