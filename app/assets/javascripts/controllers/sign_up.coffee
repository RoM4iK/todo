signUpController = ($scope, $http, $auth, Notification) ->
  $scope.submit = () ->
    $auth.submitRegistration($scope.user)
        .catch((response) ->
          response.data.errors.full_messages.forEach (error) ->
            Notification.error error
        )
angular.module('App').controller('signUpController', ['$scope', '$http', '$auth', 'Notification', signUpController])
