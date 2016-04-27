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
      }

angular.module('App').factory('Task', ['$resource', tasksFactory])
