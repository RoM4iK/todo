angular.module('App')
  .directive('projectsActions', () ->
    scope:
      id: '=id',
      editPage: '=editPage',
      delete: '&delete'
    templateUrl: 'projects/_actions.html'
  )
