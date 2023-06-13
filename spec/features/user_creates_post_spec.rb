require 'rails_helper'

RSpec.describe 'Creating posts', type: :feature do
  let(:user) { create(:user) }

  before do
    sign_in user
    Timecop.freeze(DateTime.new(2023, 6, 11, 15, 30, 10))
  end

  scenario 'creating post' do
    visit root_path
    click_link 'New Post'
    fill_in 'Title', with: 'Best Post'
    fill_in 'Body', with: 'Great Body'
    click_button 'Create Post'
    assert_current_path('/posts/1')
    expect(page).to have_content('Best Post')
    expect(page).to have_content('By Person Dude')
    expect(page).to have_content('Published on 2023-06-11 15:30')
    expect(page).to have_content('Great Body')
  end

  scenario 'creating post with too long of a title' do
    visit root_path
    click_link 'New Post'
    fill_in 'Title', with: 'a' * 31
    fill_in 'Body', with: 'Great Body'
    click_button 'Create Post'
    expect(page).to have_content("Title is too long (maximum is 30 characters)")
  end
  
  scenario 'creating post with too long of a body' do
    visit root_path
    click_link 'New Post'
    fill_in 'Title', with: 'Nice Post'
    fill_in 'Body', with: 'a' * 251
    click_button 'Create Post'
    expect(page).to have_content("Body is too long (maximum is 250 characters)")
  end
end