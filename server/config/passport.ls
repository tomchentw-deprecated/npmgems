require! {
  passport
  GithubStrategy: 'passport-github'.Strategy
}

require! {
  '../../config'
  './sequelize'
  User: '../models/user'
}

module.exports = passport

# Serialize the user id to push into the session
passport.serializeUser !(user, done) ->
  done void, user.id

# Deserialize the user object based on a pre-serialized token
# which is the user id
passport.deserializeUser !(id, done) ->
  User
    .find id
    .error done
    .then done.bind @, void

# Use github strategy
const githubConfig = do
  clientID:     '3e06d2279155f8910bae'
  clientSecret: 'aa6afb6729ad1fc4d0fe1b801f8efd0602a503e3'
  callbackURL:  'http://localhost:5000/users/auth/github/callback'

if config.env.is 'production'
  githubConfig.clientID     = that if process.env.GITHUB_CLIENT_ID
  githubConfig.clientSecret = that if process.env.GITHUB_CLIENT_SECRET
  githubConfig.callbackURL  = that if process.env.GITHUB_CALLBACK_URL

passport.use new GithubStrategy githubConfig, !(accessToken, refreshToken, profile, done) ->
  const userParam = do
    username:     profile.username
    displayName:  profile.displayName
    gravatarId:   profile._json.gravatar_id
    email:        profile.emails.0.value
    github: do
      id:           profile.id
      accessToken:  accessToken
      refreshToken: refreshToken

  sequelize.query 'SELECT * FROM "Users" WHERE "Users"."github" @> \'id=>' + profile.id + '\'', User
  .error done
  .then (users) ->
    if users.length > 0
      users.0.updateAttributes userParam
    else
      User.create userParam
  .then done.bind @, void
