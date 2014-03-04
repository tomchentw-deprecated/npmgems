!function redirectToRoot (res)
  res.redirect '/'


exports.signOut = !(req, res) ->
  req.logout!
  redirectToRoot res

exports.authCallback = !(req, res) ->
  redirectToRoot res
