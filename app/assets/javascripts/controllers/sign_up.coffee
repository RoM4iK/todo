signUpController = ($scope, $auth, Notification) ->
  $scope.submit = () ->
    $auth.submitRegistration($scope.user)
        .catch((response) ->
          console.log(response);
          response.data.errors.full_messages.forEach (error) ->
              Notification.error error
          )
angular.module('App').controller('signUpController', ['$scope', '$auth', 'Notification', signUpController])
