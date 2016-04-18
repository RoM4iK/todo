angular.module('App', ["ui.router", "templates", "ng-token-auth", "ui-notification", "ipCookie"])
  .config(($authProvider, NotificationProvider) ->
    $authProvider.configure(
        apiUrl: ''
    )
    NotificationProvider.setOptions({
            positionX: 'left'
    });
  )
