Feature: Before and After Hooks

  Background:
    * def singleResult = callonce read('classpath:helper/Dummy.feature')
    * def singleUsername = singleResult.username
    * def result = call read('classpath:helper/Dummy.feature')
    * def username = result.username
    * configure afterFeature =
    """
    function() {
        var result = karate.call('classpath:helper/Dummy.feature');
        karate.log('after feature hooks: ' + result.username);
    }
    """
    * configure afterScenario =
    """
    function() {
        var result = karate.call('classpath:helper/Dummy.feature');
        karate.log('after scenario hooks: ' + result.username);
    }
    """

  Scenario: First Scenario
    * print singleUsername
    * print username
    * print 'This is the first scenario'

  Scenario: Second Scenario
    * print singleUsername
    * print username
    * print 'This is the second scenario'
