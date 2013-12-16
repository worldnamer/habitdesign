Feature: Remove a habit
  As a user
  I want to remove habits from the list
  So ones that I've absorbed can stop taking up mind-share

  @javascript
  Scenario: One habit
    Given I have a habit
    When I remove my habit
    Then I should have no habits