angular.module('App', ["ui.router", "templates", "ng-token-auth", "ui-notification", "ipCookie", "ngResource"])
  .config(($authProvider, NotificationProvider) ->
    $authProvider.configure(
        apiUrl: ''
    )
    NotificationProvider.setOptions({
            positionX: 'left'
    });
  )
