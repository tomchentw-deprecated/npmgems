angular.module 'npmgems' <[
  ngAnimate
  ngResource
  ngSanitize
  ui.bootstrap
  ui.router
  angular.ujs
  npmgems.bootstraping
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

.run <[
        $rootScope  User
]> ++ !($rootScope, User) ->

  $rootScope._ = User._

.controller 'IndexCtrl' class

  const NPM_TEXT = 'NPM packages'
  const GEMS_TEXT = 'RubyGems'


  targetText: ->
    if @viceVersa then GEMS_TEXT else NPM_TEXT

  sourcePlaceholder: ->
    if @viceVersa then NPM_TEXT else GEMS_TEXT      

  toggleViceVersa: !->
    @viceVersa = !@viceVersa

  search: (Mapping, name) ->
    Mapping.list do
      name: name
      sourceType: if @viceVersa then 'npm' else 'gems'

  @$inject = <[
    $scope  Mapping ]>
  !($scope, Mapping) ->
    @viceVersa = false

    $scope.search = ~>
      ($scope.mappings) <-! @search Mapping, $scope.name .then

    $scope.viceVersa = !~>
      @toggleViceVersa!
      $scope.search!





