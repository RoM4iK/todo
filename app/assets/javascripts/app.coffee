angular.module('App', [
    "ui.router",
    "templates",
    "ng-token-auth",
    "ui-notification",
    "ipCookie",
    "ngResource",
    "uuid"
  ])
  .config(($authProvider, NotificationProvider) ->
    $authProvider.configure(
        apiUrl: ''
    )
    NotificationProvider.setOptions({
            positionX: 'left'
    });
  )
