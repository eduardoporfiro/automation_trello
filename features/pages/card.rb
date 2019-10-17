class Card
  include HTTParty
  base_uri ENV['TRELLO_API_URL']
  attr_accessor :token, :id_board, :id_list, :responses_code
  def initialize
    @token = ''
    @id_board = ''
    @id_list = ''
    @id_card = ''
    @responses_code = []
    @api_key = ENV['API_KEY']
    @helper = Helper.new
    @header = {'content-type': 'application/json'}
  end

  def postBoard(name)
    valores = {}
    valores['prefs_cardAging'] = 'regular'
    valores['name'] = name
    valores['defaultLabels'] = true
    valores['defaultLists'] = true
    valores['keepFromSource'] = nil
    valores['prefs_permissionLevel'] = 'public'
    valores['prefs_voting'] = 'disabled'
    valores['prefs_comments'] = 'members'
    valores['prefs_invitations'] = 'members'
    valores['prefs_selfJoin'] = true
    valores['prefs_cardCovers'] = true
    valores['prefs_background'] = 'blue'
    valores['prefs_cardAging'] = 'regular'
    valores['key'] = @api_key
    valores['token'] = @token
    response = self.class.post('/boards/', :header => @header, :body => valores)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_board = valor['id']
      @helper.add_variable @id_board, 'boards'
      puts "Bard ID: #{@id_board}".colorize :blue
    end
    response.code
  end

  def postList(name)
    valores = {}
    valores['name'] = name
    valores['idBoard'] = @id_board
    valores['key'] = @api_key
    valores['token'] = @token
    response = self.class.post('/lists/', :header => @header, :body => valores)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_list = valor['id']
      @helper.add_variable @id_list, 'lists'
      puts "List ID: #{@id_list}".colorize :blue
    end
    response.code
  end

  def postCard(name='', desc='',pos='', due='', address='', locationName='', coordinates='', idMembers='')
    @responses_code.clear
    variaveis = {}
    variaveis['name'] = name unless name.empty?
    variaveis['desc'] = desc unless desc.empty?
    variaveis['pos'] = pos unless pos.empty?
    variaveis['due'] = due unless due.empty?
    variaveis['address'] = address unless address.empty?
    variaveis['locationName'] = locationName unless locationName.empty?
    variaveis['coordinates'] = coordinates unless coordinates.empty?
    variaveis['idMembers'] = idMembers unless idMembers.empty?
    variaveis['idList'] = @id_list
    variaveis['keepFromSource'] = 'all'
    variaveis['key'] = @api_key
    variaveis['token'] = @token
    response = self.class.post('/cards/', :header => @header, :body => variaveis)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_card = valor['id']
      @helper.add_variable @id_card, 'cards'
      puts "List ID: #{@id_list}".colorize :blue
    end
    @responses_code.append response.code
    response.code
  end

  def postCardParameter(parameter, value)
    @responses_code.clear
    variaveis = {}
    variaveis['key'] = @api_key
    variaveis['token'] = @token
    variaveis[parameter] = value
    response = self.class.post('/cards/', :header => @header, :body => variaveis)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_card = valor['id']
      @helper.add_variable @id_card, 'cards'
      puts "List ID: #{@id_list}".colorize :blue
    end
    @responses_code.append response.code
    response
  end

  def putsCardParameter(parameter, value)
    @responses_code.clear
    variaveis = {}
    variaveis['key'] = @api_key
    variaveis['token'] = @token
    variaveis[parameter] = value
    variaveis['id'] = @id_card
    response = self.class.put('/cards/', :header => @header, :body => variaveis)
    @responses_code.append response.code
    response
  end

  def delete_data
    @responses_code.clear
    @responses_code = @helper.delete_all_data
  end
end