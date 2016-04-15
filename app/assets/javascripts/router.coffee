angular.module('App').config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/"
  $stateProvider.state 'index',
    url: "/",
    templateUrl: "index.html"
  $stateProvider.state 'sign_in',
    url: "/sign_in",
    templateUrl: "sign_in.html",
    controller: "signInController",
    resolve:
      auth: ($auth) ->
        return !$auth.validateUser()
  $stateProvider.state 'sign_up',
    url: "/sign_up",
    templateUrl: "sign_up.html",
    controller: "signUpController"
    resolve:
      auth: ($auth) ->
        return !$auth.validateUser()
  $stateProvider.state 'dashboard',
    url: "/dashboard",
    abstract: true
    resolve:
      auth: ($auth) ->
        return $auth.validateUser()
  $stateProvider.state 'dashboard.projects',
    url: "/",
    templateUrl: "dashboard/projects.html"
