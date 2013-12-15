Feature: Unflag a day as completed for a habit
  As a user
  I would like to unflag that I completed a habit on a given day
  So that I can correct typos

  @javascript
  Scenario: Habit with day flagged
    Given I have a habit with the first day set
    When I unflag the first day
    Then my habit should have no set days