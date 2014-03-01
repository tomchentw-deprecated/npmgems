require! <[ fs path ]>
require! <[ gulp gulp-exec gulp-header gulp-concat ]>
require! <[ gulp-livescript gulp-uglify gulp-ruby-sass ]>

const PROJECT_NAME = getJsonFile!name

function getJsonFile
  fs.readFileSync '../package.json', 'utf-8' |> JSON.parse

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
  return gulp.src path.join ...<[ stylesheets application.scss ]>
  .pipe gulp-ruby-sass do
    loadPath: [
      path.join ...<[ .. bower_components twbs-bootstrap-sass vendor assets stylesheets ]>
    ]
    cacheLocation: path.join ...<[ .. tmp .sass-cache ]>
    style: if 'production' is process.env then 'compressed' else 'nested'
  .pipe gulp.dest path.join ...<[ .. tmp public ]>

gulp.task 'client:js:ls' ->
  stream = gulp.src [
    path.join ...<[ javascripts application.ls ]>
  ]
  .pipe gulp-livescript!
  .pipe gulp-concat 'application.js'
  stream.=pipe gulp-uglify! if 'production' is process.env

  return stream.pipe getHeaderStream!
  .pipe gulp.dest path.join ...<[ .. tmp js ]>

gulp.task 'client:js' <[ client:js:ls ]> ->
  return gulp.src [
    path.join ...<[ .. bower_components angular angular.min.js ]>
    # path.join ...<[ bower_components angular-sanitize angular-sanitize.min.js ]>
    path.join ...<[ .. bower_components angular-bootstrap ui-bootstrap-tpls.min.js ]>
    path.join ...<[ .. tmp js * ]>
  ]
  .pipe gulp-concat 'application.js'
  .pipe gulp.dest path.join ...<[ .. tmp public ]>

gulp.task 'default' <[ client:css client:js ]>


