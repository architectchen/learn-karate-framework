Feature: Tests for the article page

  Background:
    # Refer file karate-config.js
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given url conduitApiUrl
    # Refer file GenerateTokenHelper.feature
    # And path 'users/login'
    # And request {"user": {"email": "conduit@example.com", "password": "conduit@example.com"}}
    # When method Post
    # Then status 200
    # * def token = response.user.token
    # Refer file karate-config.js, line 13, 14
    # * def credential = {"email": "conduit@example.com", "password": "conduit@example.com"}
    # * def response = callonce read('classpath:helper/GenerateTokenHelper.feature') credential
    # Refer file karate-config.js, line 18, 19
    # * def response = callonce read('classpath:helper/GenerateTokenHelper.feature')
    # * def token = response.token

  Scenario: Create a new article
    * def GenerateDataHelper = Java.type('helper.GenerateDataHelper')
    * def randomArticle = GenerateDataHelper.getRandomArticle()
    Given path 'articles'
    And request {"article": {"title": "#(randomArticle.title)", "description": "#(randomArticle.description)", "body": "#(randomArticle.body)"}}
    # Refer file karate-config.js, line 18, 19
    # And header Authorization = 'Token ' + token
    When method Post
    Then status 201
    And match response.article.title == '#(randomArticle.title)'
    And match response.article.author.username == 'conduit@example.com'

  Scenario: Create and delete article
    * def newArticle = read('classpath:conduitapi/json/newArticle.json')
    * def currentTags = karate.get('newArticle.article.tagList', [])
    * def newTags = karate.append(currentTags, 'Karate')
    * set newArticle.article.tagList = newTags
    Given path 'articles'
    # Refer file newArticle.json
    # And request {"article": {"title": "Job openings unexpectedly increased in May", "description": "Job", "body": "US employers moved forward on plans to increase their workforces in May, with the number of available jobs rising to a six-month high, according to Bureau of Labor Statistics data released Tuesday.", "tagList": ["CNN"]}}
    And request newArticle
    # Refer file karate-config.js, line 18, 19
    # And header Authorization = 'Token ' + token
    When method Post
    Then status 201
    * def slug = response.article.slug

    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    # Refer file karate-config.js, line 18, 19
    # And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[*].title contains 'Job openings unexpectedly increased in May'

    Given path 'articles', slug
    # Refer file karate-config.js, line 18, 19
    # And header Authorization = 'Token ' + token
    When method Delete
    Then status 204

    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    # Refer file karate-config.js, line 18, 19
    # And header Authorization = 'Token ' + token
    When method Get
    Then status 200
    And match response.articles[*].title !contains 'Job openings unexpectedly increased in May'
