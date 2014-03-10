angular.module 'npmgems.mappings' <[]>
.config <[
        $stateProvider
]> ++ !($stateProvider) ->
  $stateProvider
  .state 'Mapping' do
    abstract: true
    url: '/mappings'
    template: '<ui-view/>'

  .state 'Mapping.List' do
    templateUrl: '/mappings/list.html'
    controller: 'MappingListCtrl'
    url: '/'

  .state 'Mapping.Create' do
    templateUrl: '/mappings/create.html'
    controller: 'CreateMappingCtrl as create'
    url: '/connect'

.controller 'MappingListCtrl' class

  @$inject = <[ 
    $scope  Mapping ]>
  !($scope, Mapping) ->
    Mapping.list!then !($scope.mappings) ->

    @commentOn = angular.bind @, @commentOn, Comment

.controller 'CreateMappingCtrl' class

  withAuthorName: (gems) ->
    "#{ gems.authors }/#{ gems.name }"

  @$inject = <[
    $scope  $q  Gems  Npm  Mapping ]>
  !($scope, $q, Gems, Npm, Mapping) ->
    @info = (gemsName, npmName) ->
      $q.all [
        if gemsName then Gems.info gemsName .then !($scope.gems) ->
        if npmName then Npm.info npmName .then !($scope.npm) ->
      ]

    @connect = Mapping.create

.controller 'CreateCommentCtrl' class

  commentOn: (mapping, data) ->
    data.mappingId = mapping.id
    @_Comment.create data

  @$inject = <[
    $scope  Comment ]>
  !($scope, @_Comment) ->

