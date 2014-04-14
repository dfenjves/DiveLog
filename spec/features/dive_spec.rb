require 'spec_helper'

def create_new_dive
  first(:link, 'Log a Dive').click
  fill_in 'Dive Site:', with: "Serra Mesa"
  fill_in 'Date:', with: "07/07/1977"
  click_on('Submit Dive!')
  page.should_not have_content("Log a New Dive")
  page.should have_content("A dive at Serra Mesa")
  page.should have_content("July 7, 1977")   
end

feature 'Dive features' do
  before do
    Capybara.current_driver = :selenium
    Diver.delete_all    
  end

  given(:susan) {{name: 'Susan Amhbjgfgddjd Carrieroberg', email: 'susan_qzawldr_carrieroberg@tfbnw.net', password: '1234'}}
  given(:linda) {{name: 'Linda Amhagfihgggi Riceberg', email: 'linda_bngtqdt_riceberg@tfbnw.net', password: '1234'}}

  before :each do
    visit '/signout'
    sign_in_facebook(linda)
  end

  scenario 'creating a new dive without a date gives an error and re-renders the form' do
    first(:link, 'Log a Dive').click
    fill_in 'Dive Site:', with: "Serra Mesa"
    click_on('Submit Dive!')
    page.should have_content("Log a New Dive")
  end

  scenario 'creating a new dive without a dive site gives an error and re-renders the form' do
    first(:link, 'Log a Dive').click
    fill_in 'Date:', with: "01/25/1985"
    click_on('Submit Dive!')
    page.should have_content("Log a New Dive")
  end

  scenario 'can create a new dive' do
    create_new_dive 
  end

  feature 'editing a dive' do

    before :each do
      create_new_dive     
      @dive = Dive.last
    end

    scenario 'can change dive_type and persist in database' do
      within('[data-attribute="dive_type"]') { page.should_not have_content("Night Dive") }
      bip_select(@dive, :dive_type, "Night Dive")
      within('[data-attribute="dive_type"]') { page.should have_content("Night Dive") }
      visit dive_path(@dive)
      within('[data-attribute="dive_type"]') { page.should have_content("Night Dive") }
    end

    scenario 'can change dive_activity and persist in database' do
      within('[data-attribute="dive_activity"]') { page.should_not have_content("Training Dive") }
      bip_select(@dive, :dive_activity, "Training Dive")
      within('[data-attribute="dive_activity"]') { page.should have_content("Training Dive") }
      visit dive_path(@dive)
      within('[data-attribute="dive_activity"]') { page.should have_content("Training Dive") }
    end

    feature 'depth' do
      scenario 'can change depth and persist in database' do
        within('[data-attribute="depth"]') { page.should_not have_content("100") }
        bip_text(@dive, :depth, "100")
        within('[data-attribute="depth"]') { page.should have_content("100") }
        visit dive_path(@dive)
        within('[data-attribute="depth"]') { page.should have_content("100") }
      end

      scenario 'changing depth from nil value appends the word "meters"' do
        bip_text(@dive, :depth, "100")
        page.should have_content("meters")
      end

      scenario 'changing depth to non-integer shows an error and does not update' do
        bip_text(@dive, :depth, "abc")
        page.should have_content("Depth is not a number")        
        bip_text(@dive, :depth, "1.5")
        page.should have_content("Depth must be an integer")          
      end
    end

    feature 'temperature' do
      scenario 'can change temperature and persist in database' do
        within('[data-attribute="temperature"]') { page.should_not have_content("20") }
        bip_text(@dive, :temperature, "20")
        within('[data-attribute="temperature"]') { page.should have_content("20") }
        visit dive_path(@dive)
        within('[data-attribute="temperature"]') { page.should have_content("20") }
      end

      scenario 'changing temperature from nil value appends "C"' do
        bip_text(@dive, :temperature, "25")
        page.should have_content("C")
      end

      scenario 'changing temperature to non-integer shows an error and does not update' do
        bip_text(@dive, :temperature, "abc")
        page.should have_content("Temperature is not a number")        
        bip_text(@dive, :temperature, "1.5")
        page.should have_content("Temperature must be an integer")          
      end      
    end

    feature 'visibility' do
      scenario 'can change visibility and persist in database' do
        within('[data-attribute="visibility"]') { page.should_not have_content("50") }
        bip_text(@dive, :visibility, "50")
        within('[data-attribute="visibility"]') { page.should have_content("50") }
        visit dive_path(@dive)
        within('[data-attribute="visibility"]') { page.should have_content("50") }
      end

      scenario 'changing visibility from nil value appends "meters"' do
        bip_text(@dive, :visibility, "25")
        page.should have_content("meters")
      end 

      scenario 'changing visibility to non-integer shows an error and does not update' do
        bip_text(@dive, :visibility, "abc")
        page.should have_content("Visibility is not a number")        
      end       
    end

    scenario 'can change conditions and persist in database' do
      within('[data-attribute="conditions"]') { page.should_not have_content("Poor") }
      bip_text(@dive, :conditions, "Poor")
      within('[data-attribute="conditions"]') { page.should have_content("Poor") }
      visit dive_path(@dive)
      within('[data-attribute="conditions"]') { page.should have_content("Poor") }
    end

    feature 'start_air' do
      scenario 'can change start_air and persist in database' do
        within('[data-attribute="start_air"]') { page.should_not have_content("200") }
        bip_text(@dive, :start_air, "200")
        within('[data-attribute="start_air"]') { page.should have_content("200") }
        visit dive_path(@dive)
        within('[data-attribute="start_air"]') { page.should have_content("200") }
      end

      scenario 'changing start_air from nil value appends "bar"' do
        bip_text(@dive, :start_air, "25")
        page.should have_content("bar")
      end   

      scenario 'changing start_air to non-integer shows an error and does not update' do
        bip_text(@dive, :start_air, "abc")
        page.should have_content("Start air is not a number")        
      end         
    end

    feature 'end_air' do
      scenario 'can change end_air and persist in database' do
        within('[data-attribute="end_air"]') { page.should_not have_content("125") }
        bip_text(@dive, :end_air, "125")
        within('[data-attribute="end_air"]') { page.should have_content("125") }
        visit dive_path(@dive)
        within('[data-attribute="end_air"]') { page.should have_content("125") }
      end  
      scenario 'changing end_air from nil value appends "bar"' do
        bip_text(@dive, :end_air, "25")
        page.should have_content("bar")
      end      
      scenario 'changing end_air to non-integer shows an error and does not update' do
        bip_text(@dive, :end_air, "abc")
        page.should have_content("End air is not a number")        
      end              
    end

    scenario 'can change wetsuit and persist in database' do
      within('[data-attribute="wetsuit"]') { page.should have_content("No") }
      bip_bool(@dive, :wetsuit)
      within('[data-attribute="wetsuit"]') { page.should have_content("Yes") }
      visit dive_path(@dive)
      within('[data-attribute="wetsuit"]') { page.should have_content("Yes") }
    end    

  end

end











