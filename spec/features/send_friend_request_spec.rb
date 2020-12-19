require 'rails_helper'

RSpec.describe 'Creating an event', type: :feature do
  let!(:user1) do
    User.create(
      name: 'test',
      password: 'microverse2020',
      email: 'test@microverse.org'
    )
  end

  let!(:user2) do
    User.create(
      name: 'test2',
      password: 'microverse2020',
      email: 'test2@microverse.org'
    )
  end

  scenario 'send request with valid attributes', js: true do
    visit '/users/sign_in'
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user2.password
    click_button('Log in')
    visit '/users'
    click_link('Send Friend Request')
    expect(page).to have_content('Request sent!')
  end
end
