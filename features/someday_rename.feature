Feature: Rename someday
  As a user
  I want to be able to edit my somedays
  So I can correct typos

  @javascript
  Scenario: With a someday
    Given I have a someday habit
    When I edit the someday habit description
    Then I should see the new description on my list of someday habits