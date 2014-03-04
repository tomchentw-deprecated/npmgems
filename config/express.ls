require! <[ express express-promise jade ]>

require! {
  './passport'
}

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
    ..use express.session secret: 'keyboard cat'

    ..use express-promise!

    ..use passport.initialize!
    ..use passport.session!

createServer <<< express{'static'}
