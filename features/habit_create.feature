Feature: Create habit
  As a user
  I want to create new habits
  So I can track them

  @javascript
  Scenario: No habits
    Given I am logged-in
    When I create a habit
    Then I should see that habit on my habits list