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
    response = self.class.post('/boards/', :header => {'content-type': 'application/json'}, :body => valores)
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
    response = self.class.post('/lists/', :header => {'content-type': 'application/json'}, :body => valores)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_list = valor['id']
      @helper.add_variable @id_list, 'lists'
      puts "List ID: #{@id_list}".colorize :blue
    end
    response.code
  end

  def postCard(name='', desc='',pos='', due='', address='', locationName='', coordinates='', idMembers='')
    url = "/cards?idList=#{@id_list}&keepFromSource=all&key=#{@api_key}&token=#{@token}"
    url += "&name=#{name}" unless name.empty?
    url += "&desc=#{desc}" unless desc.empty?
    url += "&pos=#{pos}" unless pos.empty?
    url += "&due=#{due}" unless due.empty?
    url += "&address=#{address}" unless address.empty?
    url += "&locationName=#{locationName}" unless locationName.empty?
    url += "&coordinates=#{coordinates}" unless coordinates.empty?
    url += "&idMembers=#{idMembers}" unless idMembers.empty?
    response = self.class.post(url)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_card = valor['id']
      @helper.add_variable @id_card, 'cards'
      puts "List ID: #{@id_list}".colorize :blue
    end
    @responses_code.append response.code
    response.code
  end
end