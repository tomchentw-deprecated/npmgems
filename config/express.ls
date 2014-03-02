require! <[ express express-promise jade ]>

module.exports = createServer

function createServer
  express!
    ..set 'showStackError' true

    ..engine 'jade' jade.__express

    ..set 'view engine' 'jade'

    ..set 'views' './server/views'


    ..use express.cookieParser!
    ..use express.urlencoded!
    ..use express.json!
    ..use express.methodOverride!

    ..use express-promise!

createServer <<< express{'static'}
