angular.module('App').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/"
  $stateProvider.state 'index', {
    url: "/",
    templateUrl: "index.html"
  }
  $stateProvider.state 'sign_in', {
    url: "/sign_in",
    templateUrl: "sign_in.html"
  }
