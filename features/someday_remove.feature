Feature: Remove a habit
  As a user
  I want to remove somedays from the list
  So ones that I've decided don't fit can stop taking up mind-share

  @javascript
  Scenario: One someday
    Given I have a someday habit
    When I remove my someday habit
    Then I should not see any someday habits