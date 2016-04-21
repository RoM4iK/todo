angular.module('App')
  .directive('projectsActions', () ->
    scope:
      id: '=id',
      editPage: '=editPage'
    templateUrl: 'projects/_actions.html'
  )
