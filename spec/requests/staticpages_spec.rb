require 'spec_helper'

describe "Staticpages" do

	let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  describe "Home page" do
    it "should have the content 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/staticpages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/staticpages/home'
      expect(page).to have_title("#{base_title}")
    end

    it "should not have a custom page title" do
      visit '/staticpages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/staticpages/help'
      expect(page).to have_content('Help')
    end
    it "should have the right title" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/staticpages/help'
      expect(page).to have_title("#{base_title} | Help")
    end
  end

  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/staticpages/about'
      expect(page).to have_content('About Us')
    end
    it "should have the right title" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/staticpages/about'
      expect(page).to have_title("#{base_title} | About")
    end
  end

end