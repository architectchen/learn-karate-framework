# @parallel=false
Feature: Tests for user sign up

  Background:
    * def GenerateDataHelper = Java.type('helper.GenerateDataHelper')
    * configure headers = null
    Given url conduitApiUrl

  Scenario: Sign up a new user
    * def randomEmail = GenerateDataHelper.getRandomEmail()
    * def randomUsername = GenerateDataHelper.getRandomUsername()
    * print randomEmail
    * print randomUsername

    * def getRandomPassword =
    """
    function () {
      var GenerateDataHelper = Java.type('helper.GenerateDataHelper')
      var generateDataHelper = new GenerateDataHelper()
      return generateDataHelper.getRandomPassword()
    }
    """
    * def randomPassword = call getRandomPassword

    * def data = {"email": "#(randomEmail)", "username": "#(randomUsername)"}
    # * def data = {"email": "conduit@example.com", "username": "conduit@example.com"}
    Given path 'users'
    # And request {"user": {"email": "#(data.email)", "password": "conduit@example.com", "username": "#(data.username)"}}
    And request
    """
    {
        "user": {
            "email": "#(data.email)",
            "password": "#(randomPassword)",
            "username": "#(data.username)"
        }
    }
    """
    When method Post
    Then status 201
    And match response ==
    """
    {
        "user": {
            "id": "#number",
            "email": "#(data.email)",
            "username": "#(data.username)",
            "bio": null,
            "image": "#string",
            "token": "#string"
        }
    }
    """

    @parallel=false
    Scenario Outline: Validate Sign up error messages
    * def randomEmail = GenerateDataHelper.getRandomEmail()
    * def randomUsername = GenerateDataHelper.getRandomUsername()
    Given path 'users'
    And request
    """
    {
        "user": {
            "email": <email>,
            "password": <password>,
            "username": <username>
        }
    }
    """
    When method Post
    Then status 422
    And match response == <error>
    
    Examples:
      | email | password | username | error |
      | "#(randomEmail)" | "conduit@example.com" | "conduit@example.com" | {"errors":{"username":["has already been taken"]}} |
      | "conduit@example.com" | "conduit@example.com" | "#(randomUsername)" | {"errors":{"email":["has already been taken"]}} |
      | "conduit" | "conduit@example.com" | "#(randomUsername)" | {"errors":{"email":["is invalid"]}} |
      | "#(randomEmail)" | "conduit@example.com" | "conduit10086@example.com" | {"errors":{"username":["is too long (maximum is 20 characters)"]}} |
      | "#(randomEmail)" | "conduit10086@example.com" | "#(randomUsername)" | {"errors":{"password":["is too long (maximum is 20 characters)"]}} |
      | "" | "conduit@example.com" | "#(randomUsername)" | {"errors":{"email":["can't be blank"]}} |