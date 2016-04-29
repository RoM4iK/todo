angular.module('App', [
    "ui.router",
    "templates",
    "ng-token-auth",
    "ui-notification",
    "ipCookie",
    "ngResource",
    "uuid",
    "as.sortable",
    "pickadate",
    "angular-click-outside"
  ])
  .config(($authProvider, NotificationProvider, $httpProvider) ->
    $authProvider.configure(
        apiUrl: ''
        authProviderPaths: {
          facebook: '/auth/facebook'
        },
    )
    NotificationProvider.setOptions({
            positionX: 'left'
    });
    $httpProvider.interceptors.push(($q, $injector) ->
      # REVIEW: global error handlers, redirect on 404?
      responseError: (rejection) ->
        Notification = $injector.get('Notification');
        if rejection.status == 404
          $state = $injector.get('$state')
          $state.go('404')
        else
          rejection.data.errors.forEach((error) ->
            Notification.error error
          )
        return $q.reject(rejection)
    )
  )
