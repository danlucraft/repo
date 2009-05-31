Feature: Should load the application

  Background:
    Given I open an empty Repo store

  Scenario: Window opens
    Then I should see a window with title like "Repo.*/fixtures/repo-store"
