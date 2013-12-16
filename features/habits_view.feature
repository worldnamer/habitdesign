Feature: View habits
  As a user
  I would like to see my habits
  So I can do them more reliably.

  @javascript
  Scenario: No habits
    Given I am logged-in
    When I view my habits
    Then I should have no habits
    And I should see the days of the month