require! <[ fs path tiny-lr ]>
require! <[ gulp gulp-livescript gulp-uglify gulp-ruby-sass ]>
require! <[ gulp-livereload gulp-exec gulp-header gulp-concat ]>

require! {
  Q: q
  './config/express'
  './config/sequelize'
}

const PROJECT_NAME = getJsonFile!name

function getJsonFile
  fs.readFileSync 'package.json', 'utf-8' |> JSON.parse

function getHeaderStream
  const jsonFile = getJsonFile!
  const date = new Date
  gulp-header """
/*! #{ PROJECT_NAME } - v #{ jsonFile.version } - #{ date }
 * #{ jsonFile.homepage }
 * Copyright (c) #{ date.getFullYear! } [#{ jsonFile.author.name }](#{ jsonFile.author.url });
 * Licensed [#{ jsonFile.license.type }](#{ jsonFile.license.url })
 */\n
"""

function traverse (base)
  <- Q.nfcall fs.readdir, base .then

  Q.all it.map (route) ->
    const newPath = "#base#{ path.sep }#route"
    (stat) <- Q.nfcall fs.stat, newPath .then
    if stat.isDirectory! and 'middlewares' isnt route
      return traverse newPath
    if stat.isFile!
      require(newPath)(app)
    stat
/*
 * test tasks
 */
gulp.task 'test:karma' ->
  stream = gulp.src 'package.json'
  .pipe gulp-exec('karma start test/karma.js')
  
  if process.env.TRAVIS
    const TO_COVERALLS = [
      "find #{ path.join ...<[ tmp coverage ]> } -name lcov.info -follow -type f -print0"
      'xargs -0 cat'
      path.join ...<[ node_modules .bin coveralls ]>
    ].join ' | '
    stream.=pipe gulp-exec(TO_COVERALLS)
  
  return stream
/*
 * app tasks
 */
gulp.task 'client:css' ->
  return gulp.src 'client/stylesheets/application.scss'
  .pipe gulp-ruby-sass do
    loadPath: [
      'bower_components/twbs-bootstrap-sass/vendor/assets/stylesheets'
    ]
    cacheLocation: 'tmp/.sass-cache'
    style: if 'production' is process.env then 'compressed' else 'nested'
  .pipe gulp.dest 'tmp/public'

gulp.task 'client:js:ls' ->
  stream = gulp.src 'client/javascripts/application.ls'
  .pipe gulp-livescript!
  .pipe gulp-concat 'application.js'
  stream.=pipe gulp-uglify! if 'production' is process.env

  return stream.pipe getHeaderStream!
  .pipe gulp.dest 'tmp/.ls-cache'

gulp.task 'client:js' <[ client:js:ls ]> ->
  return gulp.src [
    'bower_components/angular/angular.min.js'
    # 'bower_components angular-sanitize angular-sanitize.min.js ]>
    'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
    'tmp/.ls-cache/*'
  ]
  .pipe gulp-concat 'application.js'
  .pipe gulp.dest 'tmp/public'

gulp.task 'client:all' <[ client:css client:js ]>

gulp.task 'client:develop' <[ client:all ]> ->
  gulp.watch 'client/javascripts/**/*.ls' <[ client:js ]>
  gulp.watch 'client/stylesheets/**/*.scss' <[ client:css ]>

gulp.task 'develop' <[ client:develop ]> ->
  function watchForLR ({path})
    gulp.src path .pipe gulp-livereload(livereload)

  gulp.watch 'tmp/public/**/*' watchForLR
  gulp.watch 'server/views/**/*' watchForLR
/*
 *
 */
const livereload  = tiny-lr!
const app         = express!

Q.all [
  sequelize.authenticate!
  traverse "./server/routes"
]
.then ->
  

  app.use app.router

  # app.use express.favicon!
  app.use express.static './public'
  app.use express.static './tmp/public'

  console.log 'express started at 5000'
  app.listen 5000
  livereload.listen 35729

.fail -> console.log it
