Feature: Log in
  As a user
  I want to sign in to my account
  So I can track my habits

  Scenario: No account
    Given an anonymous user
    When I log in with bad information
    Then I should get an account sign in error

  Scenario: Existing account
    Given a user with an existing account
    When I log in to my account
    Then I should be logged in