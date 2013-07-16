Feature: Sign In

    Background:
      Given I send and accept JSON

    Scenario: Successful sign in using email and password
      Given "Adam Jones" is a user with email id "admamj@example.com" and password "password123"
      And   his role is "Writer"
      When  I authenticate as the user "admamj@example.com" with the password "password123"
      And   I send a POST request to "/users/sign_in"
      Then  the response status should be "200"
      And   the JSON response should have "auth_token"
      And   the auth_token should be different from "auth_token_123"
      And   the JSON response at "user_role" should be "writer"