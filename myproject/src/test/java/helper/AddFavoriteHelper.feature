Feature: Add Favorite Helper

  Background:
    Given url conduitApiUrl

  Scenario: Add favorite
    Given path 'articles', slug, 'favorite'
    And request {}
    When method Post
    Then status 200
    * def favoritesCount = response.article.favoritesCount
