require! {
  '../controllers/gems'
}

module.exports = !(app) ->

  app.get '/api/gems/search/:keyword' gems.search
  
  app.get '/api/gems/info/:name' gems.info
