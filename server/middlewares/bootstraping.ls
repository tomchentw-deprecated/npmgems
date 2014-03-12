require! {
  User: '../models/user'
}

module.exports = (req, res, next) ->
  const safeUser = do
    result: 
      User.permittedAttributes.reduce (object, key) ->
        object[key] = (req.user || {})[key]
        object
      , {}
  
  res.bootstraping = do
    safeUser: JSON.stringify safeUser

  next!
