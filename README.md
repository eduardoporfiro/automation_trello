# Automation for Trello using Cucumber
## Este projeto faz parte do processo seletivo para a Sensedia!

# Instalação

Para instalar as dependências do projeto, por favor execute:
```` ruby
bundle install
````

# Requisitos
Para esta aplicação, é necessário ter instalado o ChromeDriver! Para isso, siga o tutorial neste [link](https://chromedriver.chromium.org/getting-started)

# Execução
Para a execução dos testes, é necessário uma API KEY. Para isso, siga o tutorial presente neste [link](https://developers.trello.com/page/authorization).
Quando criado, colocar na variável de ambiente ou no arquivo "default.env" o valor *"API_KEY"*

Para obter o Token de acesso, é necessário realizar o Login no Trello! Para isso, crie um usuário fazer e insira as informações
relacionadas a ele nas variáveis *"USER_PASS"* e *"USER_LOGIN"*. Essas informações serão utilizadas para login no Trello
utilizando Selenium como ferramenta!

## Tags
Para execução dos cenários de Card, insira:
```` ruby
   cucumber -t @card
````

Para execução dos cenários de Usuário, insira:
```` ruby
   cucumber -t @user
````

Observação: Para o cenário de Card, quando terminar a execução, existe um cenário que apaga todas as informações!
Durnte a execução, os dados de ID são salvos em um arquivo chamado *"variaveis.yml"*