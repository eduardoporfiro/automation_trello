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

  private
  def save_yaml
    File.open(@path, 'w') {|f| f.write @variaveis.to_yaml }
  end
end