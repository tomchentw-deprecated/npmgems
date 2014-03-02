angular.module 'npmgems' <[ ui.bootstrap ]>
.factory 'Gems' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->

    $http.get "/search/gems/#{ keyword }" .then ({data}) -> data

.factory 'Npm' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->

    $http.get "/search/npm/#{ keyword }" .then ({data}) -> data

.factory 'Mapping' <[
       $http
]> ++ ($http) ->

  list: ->
    $http.get '/mappings' .then ({data}) -> data.results

  create: (gems, npm) ->
    $http.post '/mappings' {gems, npm}

.controller 'MappingsCtrl' do ->

  MappingsCtrl.$inject = <[ $scope Mapping ]>

  !function MappingsCtrl ($scope, Mapping)
    Mapping.list!then !($scope.mappings) ->

  MappingsCtrl

.controller 'SearchCtrl' do ->

  SearchCtrl.$inject = <[ $scope Gems Npm Mapping ]>

  !function SearchCtrl ($scope, Gems, Npm, Mapping)
    @gems = Gems.search
    @npm = Npm.search
    @connect = Mapping.create

  SearchCtrl
