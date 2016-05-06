projectsFactory = ($resource) ->
  $resource '/projects/:id', {
    id: '@id'
  },
  {
    'update':
      method:'PATCH'
  }

angular.module('App').factory('Project', ['$resource', projectsFactory])
