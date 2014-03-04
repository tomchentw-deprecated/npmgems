require! '../../config/passport'
require! '../controllers/users'

const authConfig =  do
  scope: <[ user:email ]>
  failureRedirect: '/'


module.exports = !(app) ->
  app.delete '/users/sign_out' users.signOut

  # Setting the github oauth routes
  app.get '/users/auth/github'
    , passport.authenticate('github' authConfig)

  app.get '/users/auth/github/callback'
    , passport.authenticate('github' authConfig)
    , users.authCallback
