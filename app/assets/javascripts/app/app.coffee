angular
  .module('habitplan', ['ngRoute', 'ngResource'])
  .config([
    '$routeProvider', 
      ($routeProvider) ->
        $routeProvider
        .when('/', {templateUrl: '/habits'})
        # .when('/users/login', {templateUrl:'/users/login.html'})
        # .when('/users/register', {templateUrl:'/users/register.html'});
  ])
