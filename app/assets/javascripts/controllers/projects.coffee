projectsController = ($scope, Notification, Project, rfc4122, $state) ->
  $scope.init = () ->
    $scope.project =
      id: rfc4122.v4()
  $scope.create = (form) ->
    project = new Project($scope.project)
    project.$save()#.then(() ->
      # $state.go('projects.show')
    #)


angular.module('App').controller('projectsController', ['$scope', 'Notification', 'Project', 'rfc4122', '$state', projectsController])
