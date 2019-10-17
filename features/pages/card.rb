class Card
  include HTTParty
  base_uri ENV['TRELLO_API_URL']
  attr_accessor :token
  def initialize
    @token = ''
    @id_board = ''
    @id_list = ''
  end

  def postBoard(name)
    url = "/boards/?name=#{name}&defaultLabels=true&defaultLists=true&keepFromSource=none&prefs_permissionLevel=public"
    url += '&prefs_voting=disabled&prefs_comments=members&prefs_invitations=members'
    url += '&prefs_selfJoin=true&prefs_cardCovers=true&prefs_background=blue&prefs_cardAging=regular'
    url += "&key=#{ENV['API_KEY']}&token=#{@token}"
    response = self.class.post(url)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_board = valor['id']
      puts "Bard ID: #{@id_list}".colorize :blue
    end
    response.code
  end

  def postList(name)
    url = "/lists?name=#{name}&idBoard=#{@id_board}"
    url += "&key=#{ENV['API_KEY']}&token=#{@token}"
    response = self.class.post(url)
    if response.code == 200
      valor = JSON.parse(response.body)
      @id_list = valor['id']
      puts "List ID: #{@id_list}".colorize :blue
    end
    response.code
  end

  def postCard()
    self.class.post("/")
  end
end