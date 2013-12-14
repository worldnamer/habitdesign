angular
  .module('habitplan', ['ngRoute', 'ngResource'])
  .config([
    '$httpProvider', 
    ($httpProvider) ->
      $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');

      interceptor = [
        '$location', 
        '$rootScope', 
        '$q', 
        ($location, $rootScope, $q) ->
          success = (response) ->
            return response

          error = (response) ->
            if (response.status == 401)
              $rootScope.$broadcast('event:unauthorized');
              $location.path('/users/sign_in');
              return response;

            $q.reject(response);

          (promise) ->
            promise.then(success, error);
      ];
      $httpProvider.responseInterceptors.push(interceptor);
  ])
  .config([
    '$routeProvider', 
      ($routeProvider) ->
        $routeProvider
        .when('/', {templateUrl: '/habits'})
        .when('/users/sign_in', {templateUrl:'/users/sign_in'})
        .otherwise({redirectTo: '/'})
  ])
