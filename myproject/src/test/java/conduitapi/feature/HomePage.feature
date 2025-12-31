Feature: Tests for the home page

  Background:
    # Refer file karate-config.js
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given url conduitApiUrl

    @debug @smoke
  Scenario: Get all tags
    * configure headers = null
    # Refer keyword Background
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'tags'
    When method Get
    Then status 200
    # Refer keyword match contains
    # And match response.tags contains 'Git'
    And match response.tags contains ['Git', 'Blog']
    And match response.tags !contains 'WordPress'
    And match response.tags contains any ['foo', 'bar', 'YouTube']
    And match response.tags == '#array'
    And match each response.tags == '#string'

    @skipme
  Scenario: Get 10 articles from the page
    * configure headers = null
    * def isValidTime = read('classpath:helper/schema-like-time-validator.js')
    # Refer keyword Background
    # Given url 'https://conduit-api.bondaracademy.com/api/'
    Given path 'articles'
    # Refer keyword params
    # Given param limit = 10
    # Given param offset = 0
    And params {"limit": 10, "offset": 0}
    When method Get
    Then status 200
    And match response.articles == '#[10]'
    And match response.articlesCount == 10
    And match response == {"articles": "#array", "articlesCount": 10}
    And match response.articles[0].createdAt contains '2024'
    And match response.articles[*].favoritesCount contains 66
    # And match response.articles[*].author.bio contains null
    And match response..bio contains null
    And match each response..following == false
    And match each response..following == '#boolean'
    And match each response..favoritesCount == '#number'
    And match each response..bio == '##string'
    And match each response.articles ==
    """
    {
        "slug": "#string",
        "title": "#string",
        "description": "#string",
        "body": "#string",
        "tagList": "#array",
        "createdAt": "#? isValidTime(_)",
        "updatedAt": "#? isValidTime(_)",
        "favorited": "#boolean",
        "favoritesCount": "#number",
        "author": {
            "username": "#string",
            "bio": "##string",
            "image": "#string",
            "following": "#boolean"
        }
    }
    """

  Scenario: Conditional logic
    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    When method Get
    Then status 200
    * def article = response.articles[0]
    * def favoritesCount = article.favoritesCount

    # * if (favoritesCount == 0) karate.call('classpath:helper/AddFavoriteHelper.feature', article)
    * def result = favoritesCount == 0 ? karate.call('classpath:helper/AddFavoriteHelper.feature', article).favoritesCount : favoritesCount

    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    When method Get
    Then status 200
    And match response.articles[0].favoritesCount == result

    @ignore
  Scenario: Retry
    * configure retry = { count: 10, interval: 5000 }
    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    And retry until response.articles[0].favoritesCount == 1
    When method Get
    Then status 200

  Scenario: Sleep
    * def sleep = function(pause){ java.lang.Thread.sleep(pause) }
    Given path 'articles'
    And params {"limit": 10, "offset": 0}
    When method Get
    * eval sleep(5000)
    Then status 200

  Scenario: Number to string
    * def foo = 10
    * def json = {"bar": #(foo + '')}
    * match json == {"bar": "10"}

  Scenario: String to number
    * def foo = '10'
    * def json = {"bar": #(foo * 1)}
    * def json2 = {"bar": #(~~parseInt(foo))}
    * match json == {"bar": 10}
    * match json2 == {"bar": 10}