Feature: Tests for database validation

  Background:
    * def config = { username: 'sa', password: '', url: 'jdbc:h2:mem:testdb', driverClassName: 'org.h2.Driver' }
    * def DbUtils = Java.type('helper.DbUtils')
    * def dbUtils = new DbUtils(config)

  Scenario: Select 1
    * def result = dbUtils.readValue('SELECT 1')
    Then match result == 1
