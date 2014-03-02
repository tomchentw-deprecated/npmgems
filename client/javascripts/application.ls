angular.module 'npmgems' <[
  ui.bootstrap
  ui.router
  npmgems.templates
  npmgems.services
  npmgems.mappings
]>
.config <[
        $stateProvider  $locationProvider
]> ++ !($stateProvider, $locationProvider) ->
  $stateProvider
  .state 'Index' do
    url: '/'
    templateUrl: '/index.html'
    controller: 'IndexCtrl as index'

  $locationProvider.html5Mode true

.controller 'IndexCtrl' do ->

  const NPM_TEXT = 'NPM packages'
  const GEMS_TEXT = 'RubyGems'

  Ctrl.$inject = <[ $scope ]>

  const prototype = Ctrl::

  prototype.targetText = ->
    if @viceVersa then GEMS_TEXT else NPM_TEXT

  prototype.sourcePlaceholder = ->
    if @viceVersa then NPM_TEXT else GEMS_TEXT      

  prototype.toggleViceVersa = !->
    @viceVersa = !@viceVersa

  !function Ctrl ($scope)
    @viceVersa = false




