require! {
  '../controllers/mappings'
}

module.exports = !(app) ->

  app.get '/api/mappings' mappings.list
  
  app.post '/api/mappings' mappings.create
