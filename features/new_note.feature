Feature: I should be able to create a new note

  Scenario: Create note
    When I activate the new note command
    And I type "test/firstnote"
    And I press "Return"
    And I type "Hello World!"
    And I press "Done"
    Then there should be one note called "test/firstnote"
