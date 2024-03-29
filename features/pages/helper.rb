class Helper
  def initialize
    @path = 'features/variable/vairaveis.yml'
    @variaveis = YAML.load_file(@path)
  end

  def add_variable(id, var)
    @variaveis[var] = [] if @variaveis[var].nil?
    @variaveis[var].append(id)
    save_yaml
  end

  def has_board?
    reload
    !@variaveis['boards'].empty?
  end

  def has_token?
    reload
    !@variaveis['token'].empty?
  end

  def get_board
    reload
    @variaveis['boards'].first
  end

  def get_list
    @variaveis['lists'].first
  end

  def get_token
    reload
    @variaveis['token'].first
  end

  def has_list?
    reload
    !@variaveis['lists'].empty?
  end

  def delete_all_data
    responses = []
    @variaveis['cards'].each do |id|
      responses.append(delete_data(id, '/cards/'))
    end

    @variaveis['cards'].clear
    @variaveis['lists'].clear

    @variaveis['boards'].each do |id|
      responses.append(delete_data(id, '/boards/'))
    end
    @variaveis['boards'].clear
    @variaveis['token'].clear
    save_yaml
    responses
  end

  private
  def save_yaml
    File.open(@path, 'w') {|f| f.write @variaveis.to_yaml }
  end

  def delete_data(id, url)
    val = {}
    val['key'] = ENV['API_KEY']
    val['token'] = get_token
    response = HTTParty.delete ENV['TRELLO_API_URL'] + url + id.to_s,:header => {'content-type': 'application/json'}, :body => val
    response.code
  end

  def reload
    @path = 'features/variable/vairaveis.yml'
  end
end