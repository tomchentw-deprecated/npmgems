/*
 * Only these tasks are exposed and should be used by Makefile/User
 * Extract it out to the top
 */
!function tasksExportedForMakeFileDefinedHere
  gulp.task 'client' <[ client:css client:js ]>

  const serverTasks = <[ server:bootstraping ]>
  # We don't need to compile client files in server
  serverTasks.push 'client' unless isProduction!

  gulp.task 'server' serverTasks, !->
    server.use server.router

    
    server.use connect-livereload! unless isProduction!
    server.use express.static './public'
    server.use express.static './tmp/public' unless isProduction!
    
    server.use !(req, res) -> res.render 'index.jade' res.bootstraping

    server.listen SERVER_PORT
    livereload.listen LIVERELOAD_PORT  unless isProduction!


    gulp.watch 'client/views/**/*', <[ client:html ]>
    gulp.watch <[ client/templates/**/* client/javascripts/**/* ]>, <[ client:js ]>
    gulp.watch 'client/stylesheets/**/*', <[ client:css ]>

    console.log "started server(#SERVER_PORT), livereload(#LIVERELOAD_PORT) and watch"

  gulp.task 'publish' <[ publish:changelog ]>
/*
 * Implementation details
 *
 * blabla....
 */
require! {
  fs
  path
  Q: q
}

require! {
  gulp
  'gulp-jade'
  'gulp-ruby-sass'
  'gulp-angular-templatecache'
  'gulp-uglify'
  'gulp-livescript'
  'gulp-concat'
}

function isProduction
  'production' is process.env.NODE_ENV

unless isProduction!
  require! {
    'tiny-lr'
    'connect-livereload'
    'gulp-livereload'
  }
else
  gulp-livereload = -> gulp.dest 'tmp/ignore'
/*
 * client tasks
 */
gulp.task 'client:css' ->
  return gulp.src 'client/stylesheets/application.scss'
  .pipe gulp-ruby-sass do
    loadPath: [
      path.join ...<[ bower_components twbs-bootstrap-sass vendor assets stylesheets ]>
    ]
    cacheLocation: 'tmp/.sass-cache'
    style: if isProduction! then 'compressed' else 'nested'
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)

gulp.task 'client:templates' ->
  stream = gulp.src 'client/templates/**/*.jade'
  .pipe gulp-jade pretty: !isProduction!
  .pipe gulp-angular-templatecache do
    root: '/'
    module: 'npmgems.templates'
    standalone: true
  stream.=pipe gulp-uglify! if isProduction!
  return stream.pipe gulp.dest 'tmp/.js-cache'

gulp.task 'client:js:ls' ->
  stream = gulp.src 'client/javascripts/*.ls'
  .pipe gulp-livescript!
  .pipe gulp-concat 'application.js'
  stream.=pipe gulp-uglify! if isProduction!
  return stream.pipe gulp.dest 'tmp/.js-cache'

gulp.task 'client:js' <[ client:templates client:js:ls ]> ->
  return gulp.src [
    'bower_components/angular/angular.min.js'
    'bower_components/angular-animate/angular-animate.min.js'
    'bower_components/angular-resource/angular-resource.min.js'
    'bower_components/angular-sanitize/angular-sanitize.min.js'
    'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
    'client/javascripts/vendor/angular-ui-router.min.js'
    'client/javascripts/vendor/angular-ujs.min.js'
    'tmp/.js-cache/*.js'
  ]
  .pipe gulp-concat 'application.js'
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)
/*
 * server...s
 */
function database (sequelize)
  sequelize
  .authenticate!
  # .then sequelize.drop.bind sequelize
  .then sequelize.sync.bind sequelize
  # .then runPendingMigrations.bind sequelize

function runPendingMigrations (sequelize)
  sequelize.getMigrator do
    path: "#{ process.cwd! }/config/migrations"
    filesFilter: /\.ls$/
  .migrate!

function traverse (base)
  <- Q.nfcall fs.readdir, base .then

  Q.all it.map (route) ->
    const newPath = "#base#{ path.sep }#route"
    (stat) <- Q.nfcall fs.stat, newPath .then
    return traverse newPath if stat.isDirectory! and 'middlewares' isnt route
    require(newPath)(server) if stat.isFile!
    stat

const SERVER_PORT = process.env.PORT or 5000
const LIVERELOAD_PORT = 35729

express = void
server = livereload = void

gulp.task 'server:bootstraping' ->
  express := require './config/express'
  require! {
    './config/sequelize'
  }  
  server      := express!
  livereload  := !isProduction! and tiny-lr!

  return Q.all [
    database sequelize
    traverse './server/routes'
  ]
  .fail console.log
/*
 * publish tasks
 */
unless isProduction!
  require! {
    'gulp-util'
    'gulp-bump'
    'gulp-rename'
    'gulp-conventional-changelog'
  }

gulp.task 'publish:bump' ->
  return gulp.src  <[
    package.json
    bower.json
  ]>
  .pipe gulp-bump gulp-util.env{type or 'patch'}
  .pipe gulp.dest '.'

gulp.task 'publish:changelog' <[ publish:bump ]> ->
  return gulp.src <[ package.json CHANGELOG.md ]>
  .pipe gulp-conventional-changelog!
  .pipe gulp.dest '.'
# define!
tasksExportedForMakeFileDefinedHere!