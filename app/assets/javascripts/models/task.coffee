tasksFactory = ($resource) ->
  $resource '/tasks/:id', {
        id: '@id'
        project_uuid: '@project_uuid',
      },
      {
        'save':
          method:'POST',
          url: '/projects/:project_uuid/tasks/'
        'update':
          method:'PATCH'
        'move':
          method:'POST',
          url: '/tasks/:id/move'
      }

angular.module('App').factory('Task', ['$resource', tasksFactory])
