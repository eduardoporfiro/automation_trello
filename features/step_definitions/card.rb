Before do
  @token = ''
  @card = Card.new
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
  pending
end

Then(/^I should receive a "([^"]*)" code$/) do |code|
  pending
end