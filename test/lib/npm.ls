require! {
  '../test_helpers'
  npm: '../../lib/npm'
}

(...)<-! describe 'npm'

@timeout 10000

it 'should search npm registry' ->
  <- npm.search 'gulp-livescript' .then
  pkg = it.0

  pkg.name.should.equal 'gulp-livescript'
  
  pkg