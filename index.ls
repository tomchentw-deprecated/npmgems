require! {
  Sequelize: sequelize
  Q: q
}

const sequelize = new Sequelize 'npmgems', void, void, do
  dialect: 'postgres'
  port: 5432

sequelize.authenticate!then ->
  return it if it


  const User = sequelize.define 'User' do
    email: Sequelize.STRING
    password: Sequelize.STRING

  Q.all [
    User.sync force: true
  ]

.then ([User]) ->

  User.build do
    email: 'developer@tomchentw.com'
    password: 'secure password'
  .save!
  .then (user) ->
    console.log user 