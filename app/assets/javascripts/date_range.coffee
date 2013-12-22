class @DateRange
  constructor: () ->
    @months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    @currentDate = new Date
    @startDate = new Date(@currentDate.getFullYear(), @currentDate.getMonth(), 1)

    @calcEndDate()

  calcEndDate: () ->    
    @endDate = new Date(@startDate.getTime())
    @endDate.setMonth(@startDate.getMonth() + 1)
    @endDate.setDate(-1)

  prev: () ->
    @startDate.setMonth(@startDate.getMonth() - 1)
    
    @calcEndDate()

  next: () ->
    @startDate.setMonth(@startDate.getMonth() + 1)

    @calcEndDate()

  toString: () ->
    month = @months[@startDate.getMonth()]

    if @currentDate.getFullYear() != @startDate.getFullYear()
      "#{month} #{@startDate.getFullYear()}"
    else
      month