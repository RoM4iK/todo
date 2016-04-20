projectsController = ($scope, Notification, Project, rfc4122, $state, $stateParams) ->
  $scope.init = () ->
    $scope.project =
      id: rfc4122.v4()
  $scope.index = () ->
    $scope.projects = Project.query()
  $scope.create = (form) ->
    project = new Project($scope.project)
    project.$save()
      .then(() ->
         $state.go('projects.show', {id: project.id})
      )
      .catch((response) ->
        response.data.errors.forEach((error) ->
          Notification.error error
        )
      )
  $scope.show = () ->
    $scope.project = Project.get
      id: $stateParams.id

angular.module('App').controller('projectsController', ['$scope', 'Notification', 'Project', 'rfc4122', '$state', '$stateParams', projectsController])
