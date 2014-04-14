require 'spec_helper'

feature 'Diver features' do
  before do
    Capybara.current_driver = :selenium
    visit '/signout'
    Diver.delete_all    
  end

  given(:susan) {{name: 'Susan Amhbjgfgddjd Carrieroberg', email: 'susan_qzawldr_carrieroberg@tfbnw.net', password: '1234'}}
  given(:linda) {{name: 'Linda Amhagfihgggi Riceberg', email: 'linda_bngtqdt_riceberg@tfbnw.net', password: '1234'}}

  scenario "viewing my dives without logging in shows an error" do
    visit '/'
    click_on('My Dives')
    expect(current_path).to eq("/")
    page.should have_content('Please sign in to log a dive')
  end

  scenario "attempting to log a dive without logging in shows an error" do
    visit '/'
    click_on('Log a Dive')
    expect(current_path).to eq("/")
    page.should have_content('Please sign in to log a dive')
  end

  scenario "can sign in and out with facebook successfully" do
    sign_in_facebook(linda)
    click_on(linda[:name])
    click_on('Sign out')
    page.should have_content('Sign in with Facebook')    
  end

end



