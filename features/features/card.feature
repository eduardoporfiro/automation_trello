Feature: Testes relacionados aos Cards
Background: Get the request
  Given The Trello API from env
  And The env developer key
  When I request a access token
  And I authorize the access
  And I fill the Login and Password using env information
  Then I will be allowed to access the API
  And I stored the token

  @teste
  Scenario: Criando um card
    Given The user token
    And A board called "Teste"
    And A list called "List_teste"
    When I create a card:
    |NAME|DESCRICAO|POS|
    Then I should receive a "200" code