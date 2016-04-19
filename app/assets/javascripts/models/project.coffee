projectsFactory = ($resource) ->
  $resource '/projects/:id', {
        id: @id,
      },
      {
          'update': { method:'PUT' }
      }

angular.module('App').factory('Project', ['$resource', projectsFactory])
