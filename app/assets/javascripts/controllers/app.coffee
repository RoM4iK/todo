appController = ($scope, $rootScope, $http, $auth, $state, ipCookie, Notification) ->
  $scope.user = null;
  $scope.loaded = !ipCookie('auth_headers');
  $rootScope.$on('auth:validation-success', (ev, user) ->
    $scope.loaded = true
    $scope.user = user;
    $state.go('dashboard.projects') if !$state.includes 'dashboard'
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
angular.module('App').controller('appController', ['$scope', '$rootScope', '$http', '$auth', '$state', 'ipCookie', 'Notification', appController])
