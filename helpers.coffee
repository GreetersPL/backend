exports.authenticate = (req,roles = []) ->
  if false is req.session.user? then return false else
      user = req.session.user
      return true if user.admin 
  