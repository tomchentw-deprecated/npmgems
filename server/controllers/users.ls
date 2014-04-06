require! {
  User: '../models/user'
}

!function redirectToRoot (res)
  res.redirect '/'

exports.current = !(req, res) ->
  res.json result: User.permittedAttributes.reduce (object, key) ->
    object[key] = (req.user || {})[key]
    object
  , {}

exports.signOut = !(req, res) ->
  req.logout!
  redirectToRoot res

exports.authCallback = !(req, res) ->
  redirectToRoot res
