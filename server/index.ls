require! {
  express
  'connect-livereload'
}

require! {
  '../config'
  './config/server'
  './config/routes'
  './config/sequelize'
}

function database
  sequelize
  .authenticate!
  # .then sequelize.drop.bind sequelize
  .then sequelize.sync.bind sequelize
  # .then runPendingMigrations

function runPendingMigrations
  sequelize.getMigrator do
    path: "#{ process.cwd! }/config/migrations"
    filesFilter: /\.ls$/
  .migrate!

<-! database!then
server.use server.router

server.use connect-livereload! unless config.env.is 'production'
server.use express.static './public'
server.use express.static './tmp/public'

server.use !(req, res) -> res.render 'index.jade' res.bootstraping

server.listen config.port.express
