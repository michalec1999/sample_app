require 'spec_helper'

describe "Micropost Pages" do

	subject { page }

	let(:user) { FactoryGirl.create(:user) }
	before { sign_in user }

	describe "micropost creation" do
		before { visit root_path }


		describe "with invalid information" do

			it "should not create a micropost" do
				expect { click_button "Post" }.not_to change(Micropost, :count)
			end

			describe "error messages" do
				before { click_button "Post" }
				it { should have_content('error') }
			end

		end

		describe "with valid information" do

			before { fill_in 'micropost_content', with: "Lorem Ipsum" }
			it "should create a micropost" do
				expect { click_button "Post" }.to change(Micropost, :count)
			end
			
		end

		describe "0 micropost count" do
			it { should have_content('0 micropost') }
		end

		describe "1 micropost count" do
			before { fill_in 'micropost_content', with: "Lorem Ipsum" }
			before { click_button "Post" }
			it { should have_content('1 micropost') }
		end

		describe "2 microposts count" do
			before { fill_in 'micropost_content', with: "Lorem Ipsum" }
			before { click_button "Post" }
			before { fill_in 'micropost_content', with: "Lorem Ipsum2" }
			before { click_button "Post" }
			it { should have_content('2 microposts') }
		end

		describe "no pagination" do
			it { should_not have_content('Next') }
		end

		describe "pagination" do
      		for i in 0..30
      			before { fill_in 'micropost_content', with: "Lorem Ipsum" }
				before { click_button "Post" }
      		end
      		it { should have_selector('div.pagination') }
		end

	end

	describe "other micropost users" do
		#before { visit root_path }
		
		before { @user2 = User.new(name: "Example User2", email: "user2@example.com", password: "foobar", password_confirmation: "foobar")}
		before { @user2.save }
		before { FactoryGirl.create(:micropost, user: @user2) }

		before { visit user_path(@user2) }

		it { should have_title(@user2.name) }
		it { should have_content("Microposts (1)")}
		it { should_not have_link('delete') }

	end

	describe "micropost destruction" do
		before { FactoryGirl.create(:micropost, user: user) }

		describe "as correct user" do
			before { visit root_path }

			it "should delete a micropost" do
				expect { click_link "delete" }.to change(Micropost, :count).by(-1)
			end
		end
	end

end