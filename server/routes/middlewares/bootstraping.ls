require! {
  User: '../../models/user'
}

module.exports = (req, res, next) ->
  const safeUser = do
    result:
      if req.user
        that{id, username, displayName}
      else
        {}
  
  res.bootstraping = do
    safeUser: JSON.stringify safeUser

  console.log safeUser
  next!
