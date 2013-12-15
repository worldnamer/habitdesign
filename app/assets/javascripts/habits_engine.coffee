angular
  .module('habitplan.habits', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        all: () ->
          habits = $resource('/habits.json').query()
          habits
  )
  .controller('HabitsController',
    ($scope, $timeout, Habit) ->
      habit_resource = new Habit()

      $scope.habits = habit_resource.all()
  )