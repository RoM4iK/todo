commentsController = (
  $scope,
  Notification,
  Comment,
  rfc4122,
  $state,
  $timeout) ->

    task = $scope.$parent.task

    initComment = () ->
      $scope.comment =
        uuid: rfc4122.v4(),
        text: ''
    removeComment = (uuid) ->
      task.comments = task.comments.filter((comment) ->
        comment.uuid != uuid
      )
    $scope.create = (form) ->
      comment = new Comment($scope.comment)
      comment.task_uuid = task.uuid
      comment.$save()
        .then(() ->
          task.comments.push(comment)
          initComment()
          form.$setPristine()
        )
    $scope.delete = (id) ->
      if confirm("Are you sure to delete this comment?")
        Comment.delete({id: id}, () ->
          Notification 'Comment deleted'
          removeComment(id)
        )
    $scope.update = (comment) ->
      Comment.update({id: comment.uuid}, comment, (response) ->
        Notification 'Comment updated'
        comment = response.data
        $scope.toggleEditState()
      )
    initComment()

angular.module('App').controller('commentsController', [
  '$scope',
  'Notification',
  'Comment',
  'rfc4122',
  '$state',
  '$timeout',
  commentsController
])
