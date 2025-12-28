Feature: Generate Token Helper

  Scenario: Generate Token
    # Refer file karate-config.js
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given url conduitApiUrl
    And path 'users/login'
    And request {"user": {"email": "#(email)", "password": "#(password)"}}
    When method Post
    Then status 200
    * def token = response.user.token
