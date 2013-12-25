class @DateRange
  constructor: () ->
    @months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

    @currentDate = new Date
    @startDate = new Date(@currentDate.getFullYear(), @currentDate.getMonth(), 1)

    @calcEndDate()

  days_in_range: () ->
    days = []
    date = new Date(@startDate.getTime())

    while date <= @endDate
      days.push(date.getDate())
      date.setDate(date.getDate() + 1)

    days

  calcEndDate: () ->
    year = @startDate.getFullYear()
    month = @startDate.getMonth()
    date = 31

    @endDate = new Date(year, month, date)
    until (@endDate.getMonth() == month) or (date == 28)
      date -= 1
      @endDate = new Date(year, month, date)

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