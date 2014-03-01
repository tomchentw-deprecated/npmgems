require! {
  # Sequelize: sequelize
  Q: q
  express
  'express-promise'
  './server/controllers'
}

# const sequelize = new Sequelize 'npmgems', void, void, do
#   dialect: 'postgres'
#   port: 5432

# sequelize.authenticate!then ->
#   return it if it


#   const User = sequelize.define 'User' do
#     email: Sequelize.STRING
#     password: Sequelize.STRING

#   Q.all [
#     User.sync force: true
#   ]

# .then ([User]) ->

#   User.build do
#     email: 'developer@tomchentw.com'
#     password: 'secure password'
#   .save!
#   .then (user) ->
#     console.log user 

Q.when express!
.then (app) ->
  app.use express-promise!

  app
.then controllers
.then !(app) ->
  app.listen 5000