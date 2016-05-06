commentsFactory = ($resource) ->
  $resource '/comments/:id', {
    id: '@id'
    task_uuid: '@task_uuid'
  },
  {
    'save':
      method:'POST'
      url: '/tasks/:task_uuid/comments'
    'update':
      method:'PATCH'
  }

angular.module('App').factory('Comment', ['$resource', commentsFactory])
