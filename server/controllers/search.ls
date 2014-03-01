require! {
  npm: '../../lib/npm'
  gems: '../../lib/gems'
}

exports.npm = !(req, res) ->
  res.json npm.search req.params.keyword

exports.gems = !(req, res) ->
  res.json gems.search req.params.keyword