angular.module 'npmgems.mappings' <[]>
.config <[
        $stateProvider
]> ++ !($stateProvider) ->
  $stateProvider
  .state 'Mapping' do
    abstract: true
    url: '/mappings'
    template: '<ui-view/>'

  .state 'Mapping.Index' do
    templateUrl: '/mappings/index.html'
    controller: 'MappingIndexCtrl'
    url: '/'

  .state 'Mapping.Connect' do
    templateUrl: '/mappings/connect.html'
    controller: 'CreateMappingCtrl as create'
    url: '/connect'

.controller 'MappingIndexCtrl' class

  @$inject = <[ $scope Mapping ]>

  !($scope, Mapping) ->
    Mapping.list!then !($scope.mappings) ->

.controller 'CreateMappingCtrl' class

  @$inject = <[ $scope Gems Npm Mapping ]>

  withAuthorName: (gems) ->
    "#{ gems.authors }/#{ gems.name }"

  !($scope, Gems, Npm, Mapping) ->
    @gems = (name) ->
      Gems.info name .then !($scope.gems) ->

    @npm = (name) ->
      Npm.info name .then !($scope.npm) ->

    @connect = Mapping.create




