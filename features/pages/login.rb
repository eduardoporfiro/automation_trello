class Login
  def initialize
    @url = ''
    @api = ''
    @token = ''
    @session = @session.nil? ? Capybara.current_session : @session
  end

  def get_url_env
    raise variavel_nula 'TRELLO_URL' if ENV['TRELLO_URL'].nil?
    raise variavel_vazia 'TRELLO_URL' if ENV['TRELLO_URL'].empty?

    @url = ENV['TRELLO_URL']
  end

  def set_url(url)
    raise variavel_vazia 'URL' if url.empty?
    @url = url
  end

  def get_scret_api_key
    raise variavel_nula 'API_KEY' if ENV['API_KEY'].nil?
    raise variavel_vazia 'API_KEY' if ENV['API_KEY'].empty?

    @api = ENV['API_KEY']
  end

  def set_secret_api_key(api)
    raise variavel_vazia 'API' if api.empty?
    @api = api
  end

  def request_token
    url = @url + '1/authorize?expiration=1day&name=Sensedia&scope=read,write&response_type=token'
    url = url + "&callback_method=postMessage&key=#{@api}"
    @session.visit url
  end

  def authorize_access
    @session.find("//a[@class='button primary']").click
  end
  def login
    raise variavel_nula 'USER_PASS' if ENV['USER_PASS'].nil?
    raise variavel_vazia 'USER_PASS' if ENV['USER_PASS'].empty?
    raise variavel_nula 'USER_LOGIN' if ENV['USER_LOGIN'].nil?
    raise variavel_vazia 'USER_LOGIN' if ENV['USER_LOGIN'].empty?

    @session.find("//input[@id='user']").set ENV['USER_LOGIN']
    @session.find("//input[@id='password']").set ENV['USER_PASS']
    @session.find("//input[@id='login']").click
  end

  def allow_access
    byebug
    @session.find("//input[@id='approveButton']").click
    @token = @session.find("//pre").text
  end

  private
  def variavel_nula(variavel)
    "Por favor, configurar a variável de ambiente #{variavel} com a URL ou configurar o arquivo default.env com o valor"
  end
  def variavel_vazia(variavel)
    "A variável #{variavel} não pode estar vazia!"
  end
end