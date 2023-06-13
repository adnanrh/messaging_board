require 'rails_helper'

RSpec.describe 'Adding comments', type: :feature do
  let(:user) { create(:user) }
  let!(:post1) { create(:post, title: 'Post 1', body: 'This is Post 1s body', user: user) }

  before do
    sign_in user
  end

  scenario 'adding comments' do
    visit root_path
    click_link 'Post 1'

    Timecop.freeze(DateTime.new(2023, 6, 11, 15, 30, 10)) do
      fill_in 'comment_body', with: 'Great Read!'
      click_button 'Create Comment'
    end

    Timecop.freeze(DateTime.new(2023, 6, 11, 15, 45, 10)) do
      fill_in 'comment_body', with: 'Going to share with friends!'
      click_button 'Create Comment'
    end

    comment_elements = page.all(:css, '#comments_section p')
    first_comment_header = comment_elements[0]
    first_comment_body = comment_elements[1]
    last_comment_header = comment_elements[2]
    last_comment_body = comment_elements[3]
    expect(first_comment_header.text).to eq('Person Dude 2023-06-11 15:30')
    expect(first_comment_body.text).to eq('Great Read!')
    expect(last_comment_header.text).to eq('Person Dude 2023-06-11 15:45')
    expect(last_comment_body.text).to eq('Going to share with friends!')
  end
end