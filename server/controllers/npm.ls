require! {
  npm: '../../lib/npm'
}

exports.search = !(req, res) ->
  res.json do
    results: npm.search req.params.keyword

exports.info = !(req, res) ->
  res.json do
    result: npm.info req.params.name