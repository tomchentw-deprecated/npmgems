require! <[ express express-promise jade ]>

module.exports = ->
  const app = express!

  app.set 'showStackError' true

  app.engine 'jade' jade.__express

  app.set 'view engine' 'jade'

  app.set 'views' './server/views'


  app.use express.cookieParser!
  app.use express.urlencoded!
  app.use express.json!
  app.use express.methodOverride!

  app.use express-promise!

  app
