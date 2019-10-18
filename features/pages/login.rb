class Login
  attr_accessor :token
  def initialize
    @url = ''
    @api = ''
    @token = ''
    @helper = Helper.new
    @session = @session.nil? ? Capybara.current_session : @session
  end

  def get_url_env
    raise variavel_nula 'TRELLO_API_URL' if ENV['TRELLO_API_URL'].nil?
    raise variavel_vazia 'TRELLO_API_URL' if ENV['TRELLO_API_URL'].empty?

    @url = ENV['TRELLO_API_URL']
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
    url = @url + '/authorize?expiration=1day&name=MyPersonalToken&scope=read,write&response_type=token'
    url = url + "&key=#{@api}"
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

    login_using_var ENV['USER_LOGIN'], ENV['USER_PASS']
  end

  def allow_access
    bt = @session.find("//input[@id='approveButton']")
    while bt.disabled?
      sleep 0.5
    end
    bt.click
    @token = @session.find("//pre").text
    if @token.empty?
      raise 'Nenhum token foi retornado!'
    end
    @helper.add_variable @token, 'token'
    @session.quit
  end

  def login_pass(login, pass)
    raise variavel_vazia 'LOGIN' if login.empty?
    raise variavel_vazia 'PASS' if pass.empty?

    login_using_var login, pass
  end

  private
  def variavel_nula(variavel)
    "Por favor, configurar a variável de ambiente #{variavel} com a URL ou configurar o arquivo default.env com o valor"
  end

  def variavel_vazia(variavel)
    "A variável #{variavel} não pode estar vazia!"
  end

  def login_using_var(login, pass)
    @session.find("//input[@id='user']").set login
    @session.find("//input[@id='password']").set pass
    @session.find("//input[@id='login']").click
  end
end