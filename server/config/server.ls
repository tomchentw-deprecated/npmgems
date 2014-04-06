require! <[ express express-promise ]>

require! {
  './passport'
}

module.exports = express!
  ..set 'showStackError' true

  ..use express.cookieParser!
  ..use express.urlencoded!
  ..use express.json!
  ..use express.methodOverride!
  ..use express.session secret: 'keyboard cat'

  ..use express-promise!

  ..use passport.initialize!
  ..use passport.session!
