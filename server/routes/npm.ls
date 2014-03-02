require! {
  '../controllers/npm'
}

module.exports = !(app) ->

  app.get '/api/npm/search/:keyword' npm.search
  
  app.get '/api/npm/info/:name' npm.info
