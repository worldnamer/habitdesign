Feature: Create habit
  As a user
  I want to create new somedays
  So I can remember habits for later that I'm not willing to start now

  @javascript
  Scenario: No somedays
    Given I am logged-in
    When I create a someday
    Then I should see my someday habit