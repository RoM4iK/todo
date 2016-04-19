projectsController = ($scope, Notification, Project) ->
  $scope.create = (form) ->
    project = new Project($scope.project)
    project.$save()

angular.module('App').controller('projectsController', ['$scope', 'Notification', 'Project', projectsController])
