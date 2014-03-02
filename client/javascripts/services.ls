angular.module 'npmgems.services' <[]>
.factory 'Gems' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->
    $http.get "/api/gems/search/#{ keyword }" .then ({data}) -> data.results

  info: (name) ->
    $http.get "/api/gems/info/#{ name }" .then ({data}) -> data.result

.factory 'Npm' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->
    $http.get "/api/npm/search/#{ keyword }" .then ({data}) -> data.results

  info: (name) ->
    $http.get "/api/npm/info/#{ name }" .then ({data}) -> data.result

.factory 'Mapping' <[
       $http
]> ++ ($http) ->

  list: ->
    $http.get '/api/mappings' .then ({data}) -> data.results

  create: (gems, npm) ->
    $http.post '/api/mappings' {gems, npm}



