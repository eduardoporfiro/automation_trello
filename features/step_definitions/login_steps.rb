Before do
  @login = Login.new
end
And(/^The env developer key$/) do
  @login.get_scret_api_key
end

When(/^I request a access token$/) do
  @login.request_token
end

And(/^I authorize the access$/) do
  @login.authorize_access
end

Then(/^I will be allowed to access the API$/) do
  @login.allow_access
end

Given(/^The Trello Api URL "([^"]*)"$/) do |url|
  @login.set_url url
end

Given(/^The Trello API from env$/) do
  @login.get_url_env
end

And(/^The developer key "([^"]*)"$/) do |secret|
  @login.set_secret_api_key secret
end


And(/^I fill the Login and Password using env information$/) do
  @login.login
end

And(/^I fill the Login "([^"]*)" and Password "([^"]*)"$/) do |login, pass|
  @login.login_pass login, pass
end