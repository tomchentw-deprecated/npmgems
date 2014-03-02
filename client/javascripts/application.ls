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
    controller: 'IndexCtrl'

  $locationProvider.html5Mode true

.controller 'IndexCtrl'  do ->

  Ctrl.$inject = <[ $scope ]>

  !function Ctrl ($scope)
    void




