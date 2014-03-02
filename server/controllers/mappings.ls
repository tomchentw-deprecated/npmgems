require! {
  npm: '../../lib/npm'
  gems: '../../lib/gems'
  Mapping: '../models/mapping'
}

exports.list = !(req, res) ->
  res.json do
    results: Mapping.all!

exports.create = !(req, res) ->
  const {body} = req
  res.json Mapping.create do
    gems: body.gems.name
    npm: body.npm.name
