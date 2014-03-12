require! {
  '../test_helpers'
  npm: '../../lib/npm'
}

(...)<-! describe 'npm'

@timeout 10000

it 'should show info npm registry' ->
  <- npm.info 'gulp-livescript' .then
  it.name.should.equal 'gulp-livescript'
  it