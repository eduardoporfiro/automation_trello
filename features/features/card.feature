@card
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
    |pos         |top   |
    |due         |<FAKE_DATE>|
    |dueComplete |true  |
    |coordinates |-22.816027, -47.045577|
    |locationName|<FAKE>|
    |locationName|<FAKE>|
    |subscribed  |true  |

  Scenario Outline: Alterando o valor de um Card
    Given The user token
    And A created board
    And A created list
    And I create a card with parameter "<PARAMETER>" and value "<VALUE>"
    And I should receive a "200" code
    When I update the card with parameter "<PARAMETER>" using the new value "<NEW_VALUE>"
    Then I should receive a "200" code
    Examples:
      |PARAMETER   |VALUE |NEW_VALUE|
      |name        |<FAKE>|<FAKE>|
      |desc        |<FAKE>|<FAKE>|
      |pos         |top   |bottom|
      |due         |<FAKE_DATE>|<FAKE_DATE>|
      |dueComplete |true  |false |
      |coordinates |-22.816027, -47.045577|-22.816779, -47.046092|
      |locationName|<FAKE>|<FAKE>|
      |locationName|<FAKE>|<FAKE>|
      |subscribed  |true  |false |

  Scenario: Deletando as informações
    Given The user token
    When I delete all data created
    Then I should receive a "200" code
      