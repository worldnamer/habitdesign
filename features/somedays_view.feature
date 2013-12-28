Feature: View somedays
  As a user
  I would like to see the habits I might some day implement
  So I can think about how I might improve in the future.

  @javascript
  Scenario: No somedays
    Given I am logged-in
    When I view my habits
    Then I should not see any someday habits

  @javascript
  Scenario: With somedays
    Given I am logged-in
    And I have a someday habit
    When I view my habits
    Then I should see my someday habit

  @javascript
  Scenario: Previous pages
    Given I am logged-in
    And I have a someday habit
    When I view the previous month
    Then I should see my someday habit