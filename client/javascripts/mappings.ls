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

.controller 'MappingIndexCtrl'  do ->

  Ctrl.$inject = <[ $scope Mapping ]>

  !function Ctrl ($scope, Mapping)
    Mapping.list!then !($scope.mappings) ->

.controller 'CreateMappingCtrl' do ->

  Ctrl.$inject = <[ $scope Gems Npm Mapping ]>

  const prototype = Ctrl::

  prototype.withAuthorName = (gems) ->
    "#{ gems.authors }/#{ gems.name }"

  !function Ctrl ($scope, Gems, Npm, Mapping)
    @gems = Gems.search
    @npm = Npm.search
    @connect = Mapping.create




