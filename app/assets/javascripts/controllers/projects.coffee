projectsController = ($scope, Notification, Project, rfc4122, $state, $stateParams) ->
  $scope.init = () ->
    $scope.project =
      uuid: rfc4122.v4()
  $scope.index = () ->
    $scope.projects = Project.query()
  $scope.create = (form) ->
    project = new Project($scope.project)
    project.$save()
      .then(() ->
        Notification 'Project created'
        $state.go('projects.show', {id: project.uuid})
      )
  $scope.delete = () ->
    if confirm("Are you sure to delete this project?")
      Project.delete({id: $scope.project.uuid}, () ->
        Notification 'Project deleted'
        $state.go('projects.index')
      )
  $scope.update = (form) ->
    project = $scope.project
    Project.update({id: project.uuid}, project, () ->
         Notification 'Project updated'
         $state.go('projects.show', {id: project.uuid})
      )
  $scope.show = () ->
    $scope.project = Project.get
      id: $stateParams.id
angular.module('App').controller('projectsController', ['$scope', 'Notification', 'Project', 'rfc4122', '$state', '$stateParams', projectsController])
