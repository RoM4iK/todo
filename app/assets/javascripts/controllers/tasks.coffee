tasksController = ($scope, Notification, Task, rfc4122, $state) ->
  $('.collapsible').collapsible();

  project = $scope.$parent.project
  $scope.editState = false
  initTask = () ->
    $scope.task =
      uuid: rfc4122.v4(),
      title: ''
  removeTask = (uuid) ->
    project.tasks = project.tasks.filter((task) ->
      task.uuid != uuid
    )
  $scope.create = (form) ->
    task = new Task($scope.task)
    task.project_id = project.uuid
    task.$save()
      .then(() ->
        project.tasks.push(task)
        Notification 'Task created'
        initTask()
        form.$setPristine()
        $('.task_create_panel .collapsible-header').trigger('click')
      )
  $scope.toggleEditState = (id) ->
    $scope.editState = id
  $scope.delete = (id) ->
    if confirm("Are you sure to delete this project?")
      Task.delete({id: id}, () ->
        Notification 'Task deleted'
        removeTask(id)
      )
  $scope.update = (task) ->
    console.log(task)
    Task.update({id: task.uuid}, task, () ->
         Notification 'Task updated'
      )

  initTask()

angular.module('App').controller('tasksController', ['$scope', 'Notification', 'Task', 'rfc4122', '$state', tasksController])
