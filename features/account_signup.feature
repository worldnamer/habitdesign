Feature: Sign up
  As a user
  I want to sign up for an account
  So I can track my habits

  Scenario: No account
    Given an anonymous user
    When I sign up for an account
    Then my account should be created

  Scenario: Existing account
    Given a user with an existing account
    When I sign up again
    Then I should get an account creation error
