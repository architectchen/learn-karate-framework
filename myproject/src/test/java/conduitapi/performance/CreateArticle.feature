Feature: Tests for create article

  Background:
    Given url conduitApiUrl

  Scenario: Create and delete article
    # Refer custom feed in PerfTest.scala
    * configure headers = {"Authorization": #('Token ' + __gatling.token)}
    # Refer csv feed in PerfTest.scala
    # * def GenerateDataHelper = Java.type('helper.GenerateDataHelper')
    # * def randomArticle = GenerateDataHelper.getRandomArticle()
    Given path 'articles'
    # And request {"article": {"title": "#(randomArticle.title)", "description": "#(randomArticle.description)", "body": "#(randomArticle.body)"}}
    And request {"article": {"title": "#(__gatling.title)", "description": "#(__gatling.description)", "body": "#(__gatling.body)"}}
    And header karate-name = 'Create Article: ' + __gatling.title
    When method Post
    Then status 201
    * def slug = response.article.slug

    * karate.pause(5000)

    Given path 'articles', slug
    And header karate-name = 'Delete Article: ' + __gatling.title
    When method Delete
    Then status 204
