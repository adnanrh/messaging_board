require 'rails_helper'

RSpec.describe 'Viewing posts', type: :feature do
  let(:user) { create(:user) }
  let(:post1) { create(:post, title: 'Post 1', body: 'This is Post 1s body', user: user) }
  let(:post2) { create(:post, title: 'Post 2', body: 'This is Post 2s body', user: user) }

  before do
    sign_in user
    Timecop.freeze(DateTime.new(2023, 6, 11, 15, 30, 10)) { post1 }
    Timecop.freeze(DateTime.new(2023, 6, 11, 15, 45, 10)) { post2 }
  end

  scenario 'viewing all posts' do
    visit root_path
    posts = page.all(:css, 'li')
    expect(posts.first.text).to eq("Post 2 by Person Dude on 2023-06-11 15:45")
    expect(posts.last.text).to eq("Post 1 by Person Dude on 2023-06-11 15:30")
    links = page.all(:css, 'a')
    expect(links[0].text).to eq('New Post')
    expect(links[0][:href]).to eq('/posts/new')
    expect(links[1].text).to eq('Post 2')
    expect(links[1][:href]).to eq("/posts/#{post2.id}")
    expect(links[2].text).to eq('Post 1')
    expect(links[2][:href]).to eq("/posts/#{post1.id}")
  end

  scenario 'viewing a single post' do
    visit post_path(post2)
    expect(page).to have_content('Post 2')
    expect(page).to have_content('By Person Dude')
    expect(page).to have_content('Published on 2023-06-11 15:45')
    expect(page).to have_content('This is Post 2s body')
    expect(page).to have_content('Comments')
    expect(page).to have_css('textarea')
    expect(page.find('textarea')[:placeholder]).to eq('Add a comment...')
  end
end