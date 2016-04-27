tasksFactory = ($resource) ->
  $resource '/tasks/:id', {
        id: '@id'
        project_id: '@project_id',
      },
      {
        'save':
          method:'POST',
          url: '/projects/:project_id/tasks/'
        'update':
          method:'PATCH'
      }

angular.module('App').factory('Task', ['$resource', tasksFactory])
