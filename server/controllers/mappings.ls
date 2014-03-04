require! {
  npm: '../../lib/npm'
  gems: '../../lib/gems'
  Mapping: '../models/mapping'
}

exports.list = !(req, res) ->
  const {sourceType, name} = req.query  
  const results = if -1 is <[ npm gems ]>.indexOf sourceType
    Mapping.all!
  else
    Mapping.findAll do
      where: "#sourceType": name

  res.json {results}


exports.create = !(req, res) ->
  const {body} = req
  res.json Mapping.create do
    gems: body.gems.name
    npm: body.npm.name
