Feature: Flag a day as completed for a habit
  As a user
  I would like to flag that I completed a habit on a given day
  So that I can see the results over time

  @javascript
  Scenario: One habit
    Given I have a habit
    When I flag the first day of my habit
    Then my habit should have the first day set

  @javascript
  Scenario: Habit with day flagged
    Given I have a habit with the first day set
    When I view my habits
    Then my habit should have the first day set