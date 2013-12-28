angular
  .module('habitplan.somedays.resource', [])
  .factory('Someday',
    ($resource) ->
      class Someday
        constructor: () ->

        all: () ->
          somedays = $resource("/somedays.json").query()

        add: () ->
          someday = $resource('/somedays').save({}, () =>
            someday.renaming = true
          )
  )