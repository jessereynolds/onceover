@run
Feature: Run rspec and acceptance test suites
  Onceover should allow to run rspec and acceptance test for all profvile and role classes
  or for any part of them. Use should set if he wants to see only summary of tests or full
  log info.

  Background:
    Given onceover executable

  Scenario: Run correct spec tests
    Given initialized control repo "basic"
    When I run onceover command "run spec"
    Then I should not see any errors

  Scenario: Run spec tests with misspelled module in Puppetfile
    Given initialized control repo "basic"
    And in Puppetfile is misspelled module's name
    When I run onceover command "run spec"
    Then I should see error with message pattern "The module acme-not_exists does not exist"

  Scenario: Run with local modifications
    Given initialized control repo "basic"
    When I run onceover command "run spec"
    And I make local modifications
    And I run onceover command "run spec"
    Then I should see message pattern "local modifications"

  Scenario: Force overwrite local modifications
    Given initialized control repo "basic"
    When I run onceover command "run spec"
    And I make local modifications
    And I run onceover command "run spec --force"
    Then I should see message pattern "Overwriting local modifications"

  Scenario: Run advanced spec tests
    Given control repo "puppet_controlrepo"
    When I run onceover command "run spec"
    Then I should not see any errors

  Scenario: Check that control_branch functionality works
    Given initialized control repo "control_branch"
    When I run onceover command "run spec"
    Then the temporary Puppetfile should contain the git branch

  Scenario: Mocking functions should work and return the correct data types
    Given control repo "function_mocking"
    When I run onceover command "run spec"
    Then I should not see any errors
