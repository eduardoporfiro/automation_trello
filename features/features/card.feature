Feature: Testes relacionados aos Cards
Background: Get the request
  Given The Trello API from env
  And The env developer key
  When I request a access token if not stored

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
    |PARAMETER   |VALUE |
    |name        |<FAKE>|
    |desc        |<FAKE>|
    |pos         |<FAKE>|
    |due         |<FAKE>|
    |dueComplete |<FAKE>|
    |coordinates |<FAKE>|
    |locationName|<FAKE>|
    |locationName|<FAKE>|

  Scenario Outline: Alterando o valor de um Card
    Given The user token
    And A created board
    And A created list
    And I create a card with parameter "<PARAMETER>" and value "<VALUE>"
    And I should receive a "200" code
    When I update the card with parameter "<PARAMETER>" using the new value "<VALUE>"
    Then I should receive a "200" code
    Examples:
      |PARAMETER   |VALUE |
      |name        |<FAKE>|
      |desc        |<FAKE>|
      |pos         |<FAKE>|
      |due         |<FAKE>|
      |dueComplete |<FAKE>|
      |coordinates |<FAKE>|
      |locationName|<FAKE>|
      |locationName|<FAKE>|

    Scenario: Deletando as informações
      Given The user token
      When I delete all data created
      Then I should receive a "200" code
      