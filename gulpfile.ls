/*
 * Only these tasks are exposed and should be used by Makefile/User
 * Extract it out to the top
 */
!function tasksExportedForMakeFileDefinedHere
  gulp.task 'client' <[ client:html client:css client:js ]>

  gulp.task 'server' <[ client server:bootstraping ]> !->
    server.listen SERVER_PORT
    livereload.listen LIVERELOAD_PORT

    server.use server.router

    # server.use express.favicon!
    server.use express.static './public'
    server.use express.static './tmp/public'

    server.use !(req, res) -> res.render 'index.jade' res.bootstraping


    gulp.watch <[ client/views/**/* client/templates/**/* ]>, <[ client:html ]>
    gulp.watch 'client/javascripts/**/*', <[ client:js ]>
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
  './config/express'
  './config/sequelize'
  'connect-livereload'
  'tiny-lr'
}
require! {
  gulp
  'gulp-util'
  'gulp-livereload'
  'gulp-jade'
  'gulp-ruby-sass'
  'gulp-angular-templatecache'
  'gulp-uglify'
  'gulp-livescript'
  'gulp-concat'
}
/*
 * client tasks
 */
gulp.task 'client:html' ->
  return gulp.src 'client/views/index.jade'
  .pipe gulp-jade pretty: 'production' isnt gulp-util.env.NODE_ENV
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)

gulp.task 'client:css' ->
  return gulp.src 'client/stylesheets/application.scss'
  .pipe gulp-ruby-sass do
    loadPath: [
      path.join ...<[ bower_components twbs-bootstrap-sass vendor assets stylesheets ]>
    ]
    cacheLocation: 'tmp/.sass-cache'
    style: if 'production' is gulp-util.env.NODE_ENV then 'compressed' else 'nested'
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)

gulp.task 'client:templates' ->
  return gulp.src 'client/templates/**/*.jade'
  .pipe gulp-jade pretty: 'production' isnt gulp-util.env.NODE_ENV
  .pipe gulp-angular-templatecache do
    root: '/'
    module: 'npmgems.templates'
    standalone: true
  .pipe gulp.dest 'tmp/.js-cache'

gulp.task 'client:js:ls' ->
  stream = gulp.src 'client/javascripts/*.ls'
  .pipe gulp-livescript!
  .pipe gulp-concat 'application.js'
  stream.=pipe gulp-uglify! if 'production' is gulp-util.env.NODE_ENV
  stream.pipe gulp.dest 'tmp/.js-cache'

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
function database
  sequelize
  .authenticate!
  # .then sequelize.drop.bind sequelize
  .then sequelize.sync.bind sequelize
  .then runPendingMigrations

function runPendingMigrations
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

const SERVER_PORT = 5000
const LIVERELOAD_PORT = 35729

const server = express!
server.use connect-livereload!

const livereload = tiny-lr!

gulp.task 'server:bootstraping' ->
  return Q.all [
    database!
    traverse './server/routes'
  ]
  .fail console.log
/*
 * publish tasks
 */
require! {
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