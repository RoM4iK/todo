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
  $stateProvider.state 'projects',
    url: "/projects",
    abstract: true,
    resolve:
      auth: ($auth) ->
        return $auth.validateUser()
    template: '<ui-view/>'
  .state 'projects.index',
    url: "/",
    controller: "projectsController",
    templateUrl: "projects/index.html"
  .state 'projects.create',
    url: "/create",
    controller: "projectsController",
    templateUrl: "projects/create.html"
  .state 'projects.show',
    url: "/:id",
    controller: "projectsController",
    templateUrl: "projects/show.html"
