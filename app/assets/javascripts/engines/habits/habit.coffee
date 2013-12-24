angular
  .module('habitplan.habits.resource', [])
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