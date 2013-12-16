angular
  .module('habitplan.habits', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        days_in_range: () ->
          today = new Date()
          last_of_month = new Date(today.getFullYear(), today.getMonth(), 0).getDate()
          [1..(last_of_month+1)]

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
          habit = $resource('/habits').save({}, () =>
            today = new Date()
            last_of_month = new Date(today.getFullYear(), today.getMonth(), 0).getDate()
            habit.days = @days_in_range().map((day) -> { d: day, v: false })
            habit.renaming = true
          )

        remove: (habit) ->
          $resource("/habits/:id", {id: habit.id}).remove()

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

      $scope.days_in_range = habit_resource.days_in_range()

      $scope.add = () ->
        habit = habit_resource.add()
        habit.$promise.then(() ->
          $timeout(
            () ->
              $("input[name='habit#{habit.id}']").focus()
            0
          )
        )
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

      $scope.remove = (habit) ->
        habit_resource.remove(habit)
        $scope.habits.splice($scope.habits.indexOf(habit), 1)
  )