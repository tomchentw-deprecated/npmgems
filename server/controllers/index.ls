require! {
  Mapping: '../models/mapping'
  User: '../models/user'
}

exports.render = (req, res) ->

  res.render 'index.jade'

exports.debug = (req, res) ->

  res.json do
    mappings: Mapping.all!
    user: User.all!