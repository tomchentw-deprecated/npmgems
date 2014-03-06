require! {
  Mapping: '../models/mapping'
}

exports.render = (req, res) ->
  res.render 'index' res.bootstraping

exports.debug = (req, res) ->

  res.json do
    mappings: Mapping.all!
    user: User.all!