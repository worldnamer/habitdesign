Feature: Rename habit
  As a user
  I want to be able to edit my habits
  So I can correct typos

  @javascript
  Scenario: With a habit
  	Given a user with a habit
  	When I edit the habit description
  	Then I should see the new description on my list of habits