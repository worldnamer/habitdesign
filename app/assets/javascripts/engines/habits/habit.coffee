angular
  .module('habitplan.habits.resource', [])
  .factory('Habit',
    ($resource) ->
      class Habit
        constructor: () ->

        between: (startDate, endDate) ->
          formattedStartDate = "#{startDate.getFullYear()}-#{startDate.getMonth() + 1}-#{startDate.getDate()}"
          formattedEndDate = "#{endDate.getFullYear()}-#{endDate.getMonth() + 1}-#{endDate.getDate()}"
          habits = $resource("/habits?startDate=#{formattedStartDate}&endDate=#{formattedEndDate}", {}, 
            query:
              method: 'GET',
              headers: {
                'Accept': 'application/json'
              },
              isArray: true,
              transformResponse:
                (data, headersGetter) ->
                  habits = angular.fromJson(data);
                  for habit in habits
                    for set, i in habit.days
                      baseDate = new Date(startDate.getTime())
                      baseDate.setDate(baseDate.getDate()+i)
                      formattedDate = "#{baseDate.getFullYear()}-#{baseDate.getMonth()+1}-#{baseDate.getDate()}"
                      habit.days[i] = {d: formattedDate, v: set == 1}
                  habits
          ).query()

        add: () ->
          habit = $resource('/habits').save({}, () =>
            today = new Date()
            last_of_month = new Date(today.getFullYear(), today.getMonth(), 0).getDate()
            date_range = new DateRange
            habit.days = date_range.days_in_range().map((day) -> { d: day, v: false })
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
          $resource("/habits/:id/days/:day", {id: habit.id, day: day.d}).save()

        removeDay: (habit, day) ->
          $resource("/habits/:id/days/:day", {id: habit.id, day: day.d}).remove()
  )