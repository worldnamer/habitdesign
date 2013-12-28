angular
  .module('habitplan.somedays', ['habitplan.somedays.resource'])
  .controller('SomedaysController',
    ($scope, $timeout, Someday) ->
      somedays_resource = new Someday()
      $scope.somedays = somedays_resource.all()

      $scope.focus_someday = (someday) ->
        $timeout(
          () ->
            $("input[name='someday#{someday.id}']").focus()
          0
        )

      $scope.add = () ->
        someday = somedays_resource.add()
        someday.$promise.then(() -> $scope.focus_someday(someday))
        $scope.somedays.push(someday)

      $scope.remove = (someday) ->
        somedays_resource.remove(someday)
        $scope.somedays.splice($scope.somedays.indexOf(someday), 1)
  )