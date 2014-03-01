require! {
  Q: q
  npm: '../../lib/npm'
  gems: '../../lib/gems'
}

const actions = {}

module.exports = (app) ->
  app.get '/search/npm/:keyword' actions.npm
  app.get '/search/gems/:keyword' actions.gems

  app

actions.npm = (req, res) ->
  res.json npm.search req.params.keyword

actions.gems = !(req, res) ->
  res.json gems.search req.params.keyword