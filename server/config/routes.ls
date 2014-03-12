require! {
  './passport'
  './server'
}
require! {
  '../controllers/comments'
  '../controllers/gems'
  '../controllers/index'
  '../controllers/mappings'
  '../controllers/npm'
  '../controllers/users'
}

server.get '/api/gems/search/:keyword' gems.search
server.get '/api/gems/info/:name' gems.info

server.get '/api/npm/search/:keyword' npm.search
server.get '/api/npm/info/:name' npm.info

server.get '/api/mappings' mappings.list
server.post '/api/mappings' mappings.create

server.post '/api/comments' comments.create
server.post '/api/comments/:id' comments.update

server.get '/' index.render

const authConfig =  do
  scope: <[ user:email ]>
  failureRedirect: '/'

server.delete '/users/sign_out' users.signOut

# Setting the github oauth routes
server.get '/users/auth/github'
  , passport.authenticate('github' authConfig)

server.get '/users/auth/github/callback'
  , passport.authenticate('github' authConfig)
  , users.authCallback