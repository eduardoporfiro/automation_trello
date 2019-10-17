Feature: Testando acesos e autorização
  Scenario: Testando autenticação Básica
    Given The Trello API from env
    And The env developer key
    When I request a access token
    And I authorize the access
    And I fill the Login and Password using env information
    Then I will be allowed to access the API