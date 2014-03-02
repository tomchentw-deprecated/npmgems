require! {
  npm: '../../lib/npm'
  gems: '../../lib/gems'
}

exports.npm = !(req, res) ->
  res.json do
    results: npm.search req.params.keyword

exports.gems = !(req, res) ->
  res.json do
    results: gems.search req.params.keyword