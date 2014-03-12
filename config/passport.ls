require! {
  passport
  GithubStrategy: 'passport-github'.Strategy
}

require! {
  './sequelize'
  User: '../server/models/user'
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
const config = do
  clientID:     '3e06d2279155f8910bae'
  clientSecret: 'aa6afb6729ad1fc4d0fe1b801f8efd0602a503e3'
  callbackURL:  'http://localhost:5000/users/auth/github/callback'

if 'production' is process.env.NODE_ENV
  config.clientID     = process.env.GITHUB_CALLBACK_URL
  config.clientSecret = process.env.GITHUB_CLIENT_ID
  config.callbackURL  = process.env.GITHUB_CLIENT_SECRET

passport.use new GithubStrategy config, !(accessToken, refreshToken, profile, done) ->
  const userFetched = done.bind @, void

  sequelize.query 'SELECT * FROM "Users" WHERE "Users"."github" @> \'id=>' + profile.id + '\'', User
  .error done
  .then (users) ->
    return userFetched users.0 if users.length > 0

    User.create do
      username:     profile.username
      displayName:  profile.displayName
      email:        profile.emails.0.value
      github: do
        id:           profile.id
        accessToken:  accessToken
        refreshToken: refreshToken
  .then userFetched
