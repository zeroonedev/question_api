Given(/^the following users exists:$/) do |table|
  table.hashes.each do |user_hash|
    @user = User.create(
      name: user_hash['Name'], 
      email: user_hash['Email'],
      password: user_hash['Password'],
      password_confirmation: user_hash['Password']
    )
    expect(@user).to be_valid
    role = Role.find_by_name(user_hash['Role'])
    @user.role = role
    @user.save
  end
end

Then(/^debug the JSON$/) do
  p last_json
end

Given(/^the following roles are available:$/) do |table|
  table.hashes.each do |role_hash|
    Role.create(name: role_hash["Name"])
  end
end


When(/^I navigate to "(.*?)"$/) do |path|
  visit(path)
end

Then(/^I should see the login form$/) do
  
end

Given(/^context$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I login with the following details:$/) do |table|
  # code you wish you had
end

Then(/^I should see the$/) do
  pending # express the regexp above with the code you wish you had
end