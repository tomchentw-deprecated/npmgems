require! {
  '../test_helpers'
  gems: '../../lib/gems'
}

(...) <-! describe 'gems'

@timeout 10000

it 'should show info in rubygems registry' ->
  <- gems.info 'angular-ujs' .then
  it.name.should.equal 'angular-ujs'
  it.authors.should.equal 'tomchentw'
  
  it
