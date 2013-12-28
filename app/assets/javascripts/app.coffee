angular
  .module('habitplan', ['ngRoute', 'ngResource', 'habitplan.habits', 'habitplan.somedays'])
  .config([
    '$httpProvider', 
    ($httpProvider) ->
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
  ])
  .config([
    '$routeProvider', 
      ($routeProvider) ->
        $routeProvider
        .when('/', {templateUrl: '/habits'})
        .otherwise({redirectTo: '/'})
  ])
