Feature: Testes relacionados aos Cards
Background: Get the request
  Given The Trello API from env
  And The env developer key
  When I request a access token if not stored

  @teste
  Scenario: Criando um card
    Given The user token
    And A board called "Teste"
    And A list called "List_teste"
    When I create a card:
    |NAME|DESCRICAO|POS|
    |Sensidia|Sensidia Teste|bottom|
    Then I should receive a "200" code

  Scenario: Criando um card
    Given The user token
    And A created board
    And A created list
    When I create a card:
      |NAME|DESCRICAO|POS|
      |Sensidia|Sensidia Teste|bottom|
    Then I should receive a "200" code

    Scenario Outline: Criando um card por campo
      Given The user token
      And A created board
      And A created list
      When I create a card with parameter "<PARAMETER>" and value "<VALUE>"
      Then I should receive a "200" code
      Examples:
      |PARAMETER|VALUE|
      |name     |     |
      |desc     |     |
      |pos      |     |
      |due      |     |
      |dueComplete|   |
      |coordinates|   |
      |locationName|  |
      |locationName|  |
