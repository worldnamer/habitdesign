angular
  .module('habitplan', ['ngRoute', 'ngResource', 'habitplan.habits'])
  .config([
    '$routeProvider', 
      ($routeProvider) ->
        $routeProvider
        .when('/', {templateUrl: '/habits', controller: 'HabitsController'})
        .otherwise({redirectTo: '/'})
  ])
