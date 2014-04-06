require! {
  Q: q
  express
}
require! {
  '../config'
  './config/server'
  './config/routes'
  './config/sequelize'
}

module.exports = ->
  <- setup!then
  server.use server.router

  server.use require('connect-livereload')! unless config.env.is 'production'

  server.use express.static prefix = './public' maxAge: Infinity
  server.use express.static prefix = './tmp/public' unless config.env.is 'production'

  server.use !(req, res) -> res.sendfile "#prefix/index.html"

  const deferred = Q.defer!

  server.listen config.port.server, !->
    console.log "express started at port #{ config.port.server }" &
    deferred.resolve!

  deferred.promise
#
#
#
function setup
  database!

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
