require! {
  '../test_helpers'
  gems: '../../lib/gems'
}

(...) <-! describe 'gems'

@timeout 10000

it 'should search rubygems registry' ->
  <- gems.search 'angular-ujs' .then
  pkg = it.0

  pkg.name.should.equal 'angular-ujs'
  pkg.authors.should.equal 'tomchentw'
  
  pkg
