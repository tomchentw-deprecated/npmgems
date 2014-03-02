angular.module 'npmgems.services' <[]>
.factory 'Gems' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->

    $http.get "/search/gems/#{ keyword }" .then ({data}) -> data.results

.factory 'Npm' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->

    $http.get "/search/npm/#{ keyword }" .then ({data}) -> data.results

.factory 'Mapping' <[
       $http
]> ++ ($http) ->

  list: ->
    $http.get '/mappings' .then ({data}) -> data.results

  create: (gems, npm) ->
    $http.post '/mappings' {gems, npm}



