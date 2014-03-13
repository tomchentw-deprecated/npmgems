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

  firstOrCreateComment: ->
    for comment in @$scope.mapping.comments when comment.author.id is @$scope._.id
      return comment
    new @Comment

  go: (state) ->
    return unless @$scope._.id
    const {comment, mapping} = @$scope
    const isNewRecord = comment.isNewRecord!

    @$scope.state = if 'negative' is state
      comment.action = 'down'
      state
    else
      comment.action = 'up'
      'positive'

    comment.mappingId = mapping.id
    comment.$save!.then !->
      mapping.comments.push comment if isNewRecord

  @$inject = <[
     $scope   Comment ]>
  !(@$scope, @Comment) ->

    $scope.tooltipText = 'Please Sign In' unless $scope._.id

    $scope.comment = @firstOrCreateComment!
            
          

