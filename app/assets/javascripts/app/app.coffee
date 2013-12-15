angular
  .module('habitplan', ['ngRoute', 'ngResource'])
  .config([
    '$routeProvider', 
      ($routeProvider) ->
        $routeProvider
        .when('/', {templateUrl: '/habits'})
        .otherwise({redirectTo: '/'})
  ])
