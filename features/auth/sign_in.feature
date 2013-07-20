Feature: Sign In

    Background:
      Given the following roles are available:
      | Name     |
      | Writer   |
      | Producer |
      | Admin    |
      And the following users exists:
      | Name            | Email             | Password    | Role     |  
      | Adam Jones      | adamj@example.com | password123 | Writer   |  
      | Toni Iommi      | tonyi@example.com | password321 | Producer |  
      | Michael Dobbins | md@example.com    | passwordABC | Admin    |  

   @javascript
    Scenario: Login form
      When I navigate to "#/questions"
      Then I should see the login form

    @javascript
    Scenario Outline: Login succesfully for role
      When I login with the following details:
      | Name   | Email   | Password   |
      | <Name> | <Email> | <Password> | 
        
      Then  I should see the 
      And   the JSON response at "success" should be true
      And   the JSON response at "user/role/name" should be "<Role>"
      Examples:
      | Name            | Email             | Password    | Role     |  
      | Adam Jones      | adamj@example.com | password123 | Writer   |  
      | Toni Iommi      | tonyi@example.com | password321 | Producer |  
      | Michael Dobbins | md@example.com    | passwordABC | Admin    |  

    # Scenario: Failed sign in with incorrect details
    #   When  I send a POST request to "/users/sign_in"
    #     """
    #     { "user":{ "email":"adamj@example.com", "password":"badpassword" }}
    #     """
    #   Then  the response status should be "200"
    #   And   the JSON response should be:
    #     """
    #     { "success": false, "errors":["Login failed."]}
    #     """
    # Scenario: API consumer attempts to accesses a resource when not authenticate
    #   When  I send a GET request to "/questions.json"
    #   Then  the response status should be "302"

    # @allow-rescue
    # Scenario: Writer tries to access and episode
    #   When  I send a POST request to "/users/sign_in"
    #     """
    #     { "user":{ "email": "adamj@example.com" , "password": "password123" }}
    #     """
    #   And   I send a GET request to "/episodes"
    #   Then  the response status should be "401"
    
    
    



    
    
