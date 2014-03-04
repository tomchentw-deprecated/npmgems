require! {
  Mapping: '../models/mapping'
  User: '../models/user'
}

exports.render = (req, res) ->
  const safeUser = if req.user
    that{id, username, displayName}
  else
    null

  res.render 'index' do
    user: JSON.stringify safeUser

exports.debug = (req, res) ->

  res.json do
    mappings: Mapping.all!
    user: User.all!