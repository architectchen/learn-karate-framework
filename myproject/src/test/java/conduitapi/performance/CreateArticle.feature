Feature: Tests for create article

  Background:
    Given url conduitApiUrl

  Scenario: Create and delete article
    * def GenerateDataHelper = Java.type('helper.GenerateDataHelper')
    * def randomArticle = GenerateDataHelper.getRandomArticle()
    Given path 'articles'
    And request {"article": {"title": "#(randomArticle.title)", "description": "#(randomArticle.description)", "body": "#(randomArticle.body)"}}
    When method Post
    Then status 201
    * def slug = response.article.slug

    * karate.pause(5000)

    Given path 'articles', slug
    When method Delete
    Then status 204
