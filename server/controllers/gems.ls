require! {
  gems: '../../lib/gems'
}

exports.search = !(req, res) ->
  res.json do
    results: gems.search req.params.keyword

exports.info = !(req, res) ->
  res.json do
    results: gems.info req.params.name