appController = ($scope, $rootScope, $http, $auth, $state, Notification) ->
  $scope.user = null;
  $rootScope.$on('auth:validation-success', (ev, user) ->
    console.log('User:', user);
    $scope.user = user;
  )
  $rootScope.$on('auth:registration-email-success', (ev, user) ->
    Notification 'Successfully registered'
    $scope.user = user;
  )
  $rootScope.$on('auth:login-success', (ev, user) ->
    Notification 'Successfully signed in'
    $scope.user = user;
    $state.go('dashboard.projects')
  )
  $rootScope.$on('auth:logout-success', (ev, user) ->
    Notification 'Successfully signed out'
    $scope.user = user;
    $state.go('index')
  )
  $scope.sign_out = () ->
    $auth.signOut()
angular.module('App').controller('appController', ['$scope', '$rootScope', '$http', '$auth', '$state', 'Notification', appController])
