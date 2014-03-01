require! '../controllers/index'

module.exports = !(app) ->
  
  app.get '/' index.render

  app.get '/debug' index.debug