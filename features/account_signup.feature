Feature: Sign up
  As a user
  I want to sign up for an account
  So I can track my habits

  Scenario: No account
    Given I am unregistered
    When I sign up for an account
    Then my account should be created

  Scenario: Existing account
    Given I am a user
    When I sign up again
    Then I should get an account creation error
