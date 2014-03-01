require! '../controllers/search'

module.exports = !(app) ->

  app.get '/search/npm/:keyword' search.npm
  
  app.get '/search/gems/:keyword' search.gems
