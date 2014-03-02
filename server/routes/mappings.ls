require! '../controllers/mappings'

module.exports = !(app) ->

  app.get '/mappings' mappings.list
  
  app.post '/mappings' mappings.create
