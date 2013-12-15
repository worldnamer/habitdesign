angular
  .module('habitplan.habits', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        all: () ->
          habits = $resource('/habits.json').query()
          habits

        add: () ->
          habit = $resource('/habits').save()
  )
  .controller('HabitsController',
    ($scope, $timeout, Habit) ->
      habit_resource = new Habit()
      $scope.habits = habit_resource.all()

      $scope.add = () ->
        habit = habit_resource.add()
        $scope.habits.push(habit)
  )