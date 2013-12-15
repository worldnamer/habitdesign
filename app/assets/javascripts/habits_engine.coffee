angular
  .module('habitplan.habits', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        all: () ->
          habits = $resource('/habits.json', {}, 
            query:
              method: 'GET',
              isArray: true,
              transformResponse:
                (data, headersGetter) ->
                  habits = angular.fromJson(data);
                  for habit in habits
                    for day, i in habit.days
                      habit.days[i] = {d: i+1, v: day == 1}
                  habits

          ).query()

        add: () ->
          $resource('/habits').save()

        update: (habit) ->
          $resource("/habits/:id", {id: habit.id},
            update:
              method: 'PUT'
          ).update(habit)

        setDay: (habit, day) ->
          today = new Date()
          day = "#{today.getFullYear()}-#{today.getMonth()+1}-#{day.d}"
          $resource("/habits/:id/days/:day", {id: habit.id, day: day}).save()

        removeDay: (habit, day) ->
          today = new Date()
          day = "#{today.getFullYear()}-#{today.getMonth()+1}-#{day.d}"
          $resource("/habits/:id/days/:day", {id: habit.id, day: day}).remove()
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

      $scope.changeDay = (habit, day) ->
        if day.v
          habit_resource.setDay(habit, day)
        else
          habit_resource.removeDay(habit, day)
  )