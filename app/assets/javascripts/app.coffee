angular.module('App', ["ui.router", "templates", "ng-token-auth", "ui-notification"]).config(($authProvider) ->
  $authProvider.configure(
      apiUrl: 'http://localhost:3000'
  )
).run(($http) ->
  $http.defaults.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').content
)
