!function exportedTasksDefinedBeginsHere
  gulp.task 'client' <[ client:html client:css client:js ]> !->
    return if config.env.is 'production'
    livereload.listen config.port.livereload

    gulp.watch 'client/views/**/*', <[ client:html ]>
    gulp.watch <[ client/templates/**/* client/javascripts/**/* ]>, <[ client:js ]>
    gulp.watch 'client/stylesheets/**/*', <[ client:css ]>
/*
 * Implementation details
 */
require! {
  path
}
require! {
  gulp
  'gulp-jade'
  'gulp-ruby-sass'
  'gulp-minify-css'
  'gulp-angular-templatecache'
  'gulp-uglify'
  'gulp-livescript'
  'gulp-concat'
  'gulp-livereload'
}
require! {
  'tiny-lr'
  'connect-livereload'
}
require! {
  '../config'
}

const livereload = tiny-lr!
/*
 * client tasks
 */
gulp.task 'client:html' ->
  return gulp.src 'client/views/**/*.jade'
  .pipe gulp-jade pretty: !config.env.is 'production'
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)

gulp.task 'client:css:scss' ->
  return gulp.src 'client/stylesheets/application.scss'
  .pipe gulp-ruby-sass do
    loadPath: [
      path.join ...<[ bower_components twbs-bootstrap-sass vendor assets stylesheets ]>
    ]
    cacheLocation: 'tmp/.sass-cache'
    style: if config.env.is 'production' then 'compressed' else 'nested'
  .pipe gulp.dest 'tmp/.css-cache'

gulp.task 'client:css:angular-csp' ->
  stream = gulp.src 'bower_components/angular/angular-csp.css'
  stream.=pipe gulp-minify-css! if config.env.is 'production'
  return stream.pipe gulp.dest 'tmp/.css-cache'

gulp.task 'client:css' <[ client:css:scss client:css:angular-csp ]> ->
  return gulp.src 'tmp/.css-cache/*.css'
  .pipe gulp-concat 'application.css'
  .pipe gulp.dest 'tmp/public'
  .pipe gulp-livereload(livereload)

gulp.task 'client:templates' ->
  stream = gulp.src 'client/templates/**/*.jade'
  .pipe gulp-jade pretty: !config.env.is 'production'
  .pipe gulp-angular-templatecache do
    root: '/'
    module: "#{ config.readJsonFile!name }.templates"
    standalone: true
  stream.=pipe gulp-uglify! if config.env.is 'production'
  return stream.pipe gulp.dest 'tmp/.js-cache'

gulp.task 'client:js:ls' ->
  stream = gulp.src 'client/javascripts/*.ls'
  .pipe gulp-livescript!
  .pipe gulp-concat 'application.js'
  stream.=pipe gulp-uglify! if config.env.is 'production'
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
# define!
exportedTasksDefinedBeginsHere!
