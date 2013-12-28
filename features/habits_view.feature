Feature: View habits
  As a user
  I would like to see my habits
  So I can do them more reliably.

  @javascript
  Scenario: No habits
    Given I am logged-in
    When I view my habits
    Then I should have no habits
    And I should see the current month

  @javascript
  Scenario: Old habits
  	Given I am logged-in
  	And I have an old habit
  	When I view the previous month
  	Then I should see the habit

  @javascript
  Scenario: A new habit
    Given I am logged-in
    And I have a habit
    When I view the previous month
    Then I should have no habits
