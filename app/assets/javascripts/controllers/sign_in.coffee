signInController = ($scope, $http, $auth, Notification) ->
  $scope.submit = () ->
    $auth.submitLogin($scope.user)
        .catch((response) ->
          response.data.errors.full_messages.forEach (error) ->
            Notification.error error
        )
angular.module('App').controller('signInController', ['$scope', '$http', '$auth', 'Notification', signInController])
