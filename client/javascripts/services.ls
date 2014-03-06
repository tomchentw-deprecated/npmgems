angular.module 'npmgems.services' <[
  ngResource
  npmgems.bootstraping
]>
.config <[
        $httpProvider
]> ++ !($httpProvider) ->

  $httpProvider.interceptors.push 'npmgemsInterceptor'

.factory 'npmgemsInterceptor' <[
       $q
]> ++ ($q) ->

  response: (response) ->
    const {data} = response
    if data.errors or data.error
      $q.reject that
    else
      response.data = data.results or data.result or data
      response

.factory 'Gems' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->
    $http.get "/api/gems/search/#{ keyword }" .then ({data}) -> data

  info: (name) ->
    $http.get "/api/gems/info/#{ name }" .then ({data}) -> data

.factory 'Npm' <[
       $http
]> ++ ($http) ->

  search: (keyword) ->
    $http.get "/api/npm/search/#{ keyword }" .then ({data}) -> data

  info: (name) ->
    $http.get "/api/npm/info/#{ name }" .then ({data}) -> data

.factory 'User' <[
       $resource  $bootstrapingCache
]> ++ ($resource, $bootstrapingCache) ->

  const User = $resource '/api/users/:userId', {userId: '@id'}, do
    get: do
      method: 'GET'
      isArray: false
      cache: $bootstrapingCache

  User._ = User.get userId: '_'
  
  User

.factory 'Mapping' <[
       $http
]> ++ ($http) ->

  list: (params) ->
    $http.get '/api/mappings' {params} .then ({data}) -> data

  create: (gems, npm) ->
    $http.post '/api/mappings' {gems, npm}



