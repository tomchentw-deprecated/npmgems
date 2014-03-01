require! <[ fs path temp ]>
require! <[ gulp gulp-util gulp-exec gulp-rename gulp-header gulp-concat ]>
require! <[ gulp-livescript gulp-uglify gulp-ruby-sass gulp-jade ]>
require! <[ connect connect-livereload tiny-lr  ]>
require! <[ gulp-livereload gulp-bump gulp-conventional-changelog ]>

const PROJECT_NAME = getJsonFile!name

function getJsonFile
  fs.readFileSync 'package.json', 'utf-8' |> JSON.parse

/*
 * test tasks
 */
gulp.task 'test:protractor' ->
  stream = gulp.src 'package.json'
  
  # stream.=pipe gulp-exec [
  #   'cd test/scenario-rails'
  #   'bundle install'
  #   'RAILS_ENV=test rake db:drop db:migrate'
  #   'rails s -d -e test -p 2999'
  #   'cd ../..'
  # ].join ' && ' unless process.env.TRAVIS
  
  stream.=pipe gulp-exec("protractor #{ path.join ...<[ test protractor.js ]> }")
  # stream.=pipe gulp-exec('kill $(lsof -i :2999 -t)') unless process.env.TRAVIS
  
  return stream
/*
 * server...s
 */
const server = connect!
server.use connect-livereload!
server.use connect.static 'public'
server.use connect.static path.join ...<[ tmp public ]>

const livereload = tiny-lr!
/*
 * Public tasks: 
 *
 * test, develop
 */
const appAndTest = <[ app:html app:css app:js test ]>

gulp.task 'test' <[ test:karma test:protractor ]>

gulp.task 'develop' appAndTest, !->
  server.listen 5000
  livereload.listen 35729

  gulp.watch path.join(...<[ app views ** * ]>), <[ app:html ]>
  gulp.watch path.join(...<[ app assets javascripts ** * ]>), <[ app:js ]>
  gulp.watch path.join(...<[ app assets stylesheets ** * ]>), <[ app:css ]>

  gulp.watch path.join(...<[ lib ** * ]>), <[ test:karma app:js ]>

gulp.task 'release' <[ release:git release:rubygems ]>

gulp.task 'release:app' appAndTest, (cb) ->
  const {version} = getJsonFile!

  (err, dirpath) <-! temp.mkdir PROJECT_NAME
  return cb err if err
  gulp.src 'package.json'
  .pipe gulp-exec "cp -r #{ path.join ...<[ public * ]> } #{ dirpath }"
  .pipe gulp-exec "cp -r #{ path.join ...<[ tmp public * ]> } #{ dirpath }"
  .pipe gulp-exec 'git checkout gh-pages'
  .pipe gulp-exec 'git clean -f -d'
  .pipe gulp-exec 'git rm -rf .'
  .pipe gulp-exec "cp -r #{ path.join dirpath, '*' } ."
  .pipe gulp-exec "rm -rf #{ dirpath }"
  .pipe gulp-exec 'git add -A'
  .pipe gulp-exec "git commit -m 'chore(release): tomchentw/#{ PROJECT_NAME }@v#{ version }'"
  .pipe gulp-exec 'git push'
  .pipe gulp-exec 'git checkout master'
  .on 'end' cb
/*
 * Public tasks end 
 *
 * release tasks
 */
gulp.task 'release:bump' ->
  return gulp.src <[
    package.json
    bower.json
  ]>
  .pipe gulp-bump gulp-util.env{type or 'patch'}
  .pipe gulp.dest '.'

gulp.task 'release:lib' <[ release:bump ]> ->
  return gulp.src LIB_FILE
  .pipe gulp-livescript!
  .pipe getHeaderStream!
  .pipe gulp.dest path.join ...<[ vendor assets javascripts ]>
  .pipe gulp.dest '.'
  .pipe gulp-uglify preserveComments: 'some'
  .pipe gulp-rename extname: '.min.js'
  .pipe gulp.dest '.'

gulp.task 'release:commit' <[ release:lib ]> ->
  const jsonFile = getJsonFile!
  const commitMsg = "chore(release): v#{ jsonFile.version }"

  return gulp.src <[ package.json CHANGELOG.md ]>
  .pipe gulp-conventional-changelog!
  .pipe gulp.dest '.'
  .pipe gulp-exec('git add -A')
  .pipe gulp-exec("git commit -m '#{ commitMsg }'")
  .pipe gulp-exec("git tag -a v#{ jsonFile.version } -m '#{ commitMsg }'")

gulp.task 'release:git' <[ release:commit ]> ->
  return gulp.src 'package.json'
  .pipe gulp-exec('git push')
  .pipe gulp-exec('git push --tags')

gulp.task 'release:rubygems' <[ release:commit ]> ->
  return gulp.src 'package.json'
  .pipe gulp-exec('rake release')

