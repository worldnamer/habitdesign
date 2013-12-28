angular
  .module('habitplan.somedays', ['habitplan.somedays.resource'])
  .controller('SomedaysController',
    ($scope, $timeout, Someday) ->
      somedays_resource = new Someday()
      $scope.somedays = somedays_resource.all()
  )