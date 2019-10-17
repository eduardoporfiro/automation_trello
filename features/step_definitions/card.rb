Before do
  @token = ''
  @card = Card.new
  @helper = Helper.new
end

And(/^I stored the token$/) do
  @card.token = @login.token
end

Given(/^The user token$/) do
  expect(@card.token.empty?).to eq(false)
end

And(/^A board called "([^"]*)"$/) do |board|
  expect(@card.postBoard(board)).to eq(200)
end

And(/^A list called "([^"]*)"$/) do |list|
  expect(@card.postList(list)).to eq(200)
end

When(/^I create a card:$/) do |table|
  table.hashes.each do |line|
    @card.postCard line['NAME'], line['DESCRICAO'], line['POS']
  end
end

Then(/^I should receive a "([^"]*)" code$/) do |code|
  @card.responses_code.each do |code_s|
    expect(code_s).to eq(code.to_i)
  end
end

And(/^A created board$/) do
  unless @helper.has_board?
    step "A board called \"Teste\""
  end
  @card.id_board = @helper.get_board
end

And(/^A created list$/) do
  unless @helper.has_list?
    step "A list called \"Teste\""
  end
  @card.id_list = @helper.get_list
end

When(/^I create a card with parameter "([^"]*)" and value "([^"]*)"$/) do |arg1, arg2|
  pending
end