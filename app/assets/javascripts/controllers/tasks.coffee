tasksController = ($scope, Notification, Task, rfc4122, $state) ->
  $('.collapsible').collapsible();

  project = $scope.$parent.project
  $scope.editState = false
  initTask = () ->
    $scope.task =
      uuid: rfc4122.v4(),
      title: ''
  findTask = (uuid) ->
     project.tasks.filter((task) ->
      task.uuid == uuid
    )[0]
  removeTask = (uuid) ->
    project.tasks = project.tasks.filter((task) ->
      task.uuid != uuid
    )
  $scope.create = (form) ->
    task = new Task($scope.task)
    task.project_uuid = project.uuid
    task.$save()
      .then(() ->
        project.tasks.push(task)
        Notification 'Task created'
        initTask()
        form.$setPristine()
        $('.tasks_create_panel .collapsible-header').trigger('click')
      )
  $scope.toggleEditState = (uuid) ->
    currentTask = findTask(uuid)
    if currentTask
      $scope.newTitle = currentTask.title
    $scope.editState = uuid
  $scope.delete = (id) ->
    if confirm("Are you sure to delete this project?")
      Task.delete({id: id}, () ->
        Notification 'Task deleted'
        removeTask(id)
      )
  $scope.update = (task) ->
    Task.update({id: task.uuid}, task, (response) ->
         Notification 'Task updated'
         task = response.data
         $scope.toggleEditState()
      )

  initTask()

angular.module('App').controller('tasksController', ['$scope', 'Notification', 'Task', 'rfc4122', '$state', tasksController])
