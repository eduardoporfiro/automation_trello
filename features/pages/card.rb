class Card
  include HTTParty
  base_uri ENV['TRELLO_API_URL']
  attr_accessor :token
  def initialize
    @token = ''
  end

  def postBoard(name)
    url = "/boards/?name=#{name}&defaultLabels=true&defaultLists=true&keepFromSource=none&prefs_permissionLevel=public"
    url = url + "&prefs_voting=disabled&prefs_comments=members&prefs_invitations=members"
    url = url + "&prefs_selfJoin=true&prefs_cardCovers=true&prefs_background=blue&prefs_cardAging=regular"
    url = url + "&key=#{ENV['API_KEY']}&token=#{@token}"
    response = self.class.post(url)
    response.code
  end

  def postList(name)
    self.class.post("/lists?name=#{name}&idBoard=#{@id_board}&idListSource=a&pos=a&key=#{ENV{'API_KEY'}}&token=#{@token}")
  end

  def postCard()
    self.class.post("/")
  end
end