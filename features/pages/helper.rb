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
    !@variaveis['boards'].empty?
  end

  def has_token?
    !@variaveis['token'].empty?
  end

  def get_board
    @variaveis['boards'].first
  end

  def get_list
    @variaveis['lists'].first
  end

  def get_token
    @variaveis['token'].first
  end

  def has_list?
    !@variaveis['lists'].empty?
  end

  def delete_all_data
    responses = []
    @variaveis['cards'].each do |id|
      responses.append(delete_data(id, '/cards/'))
    end

    @variaveis['lists'].each do |id|
      responses.append(delete_data(id, '/lists/'))
    end

    @variaveis['boards'].each do |id|
      responses.append(delete_data(id, '/boards/'))
    end
    responses
  end

  private
  def save_yaml
    File.open(@path, 'w') {|f| f.write @variaveis.to_yaml }
  end

  def delete_data(id, url)
    val = {}
    val['key'] = ENV['API_KEY']
    val['token'] = @card.token
    val['id'] = id
    response = HTTParty.delete url,:header => {'content-type': 'application/json'}, :body => val
    response.code
  end
end