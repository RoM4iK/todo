signInController = ($scope, $auth, Notification) ->
  $scope.submit = () ->
    $auth.submitLogin($scope.user)
        .catch((response) ->
          console.log(response);
          response.errors.forEach (error) ->
            Notification.error error
        )
angular.module('App').controller('signInController', ['$scope', '$auth', 'Notification', signInController])
