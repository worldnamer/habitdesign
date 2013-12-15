angular
  .module('habitplan.habits', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        all: () ->
          $resource('/habits.json').query()

        add: () ->
          $resource('/habits').save()

        update: (habit) ->
          $resource("/habits/:id", {id: habit.id},
            update:
              method: 'PUT'
          ).update(habit)

  )
  .controller('HabitsController',
    ($scope, $timeout, Habit) ->
      habit_resource = new Habit()
      $scope.habits = habit_resource.all()

      $scope.add = () ->
        habit = habit_resource.add()
        $scope.habits.push(habit)

      $scope.rename = (habit) ->
        description = $("td##{habit.id} form input").val()

        habit.description = description
        delete habit.renaming

        habit_resource.update(habit)
  )