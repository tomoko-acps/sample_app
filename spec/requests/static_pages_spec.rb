require 'spec_helper'
require 'support/utilities'

describe "Static Page" do

	subject { page }

	shared_examples_for "all static pages" do
		it { expect have_content(heading) }
		it { expect have_title(full_title(page_title)) }
	end
	describe "Home page" do
		before {visit root_path}
		let(:heading)   { 'Sample App' }
		let(:page_title){ '' }

		it_should_behave_like "all static pages"
		it { expect be_falsy have_title('| Home')} # 否定形の時

		describe "for signed-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
				FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					# 各フィード項目が固有のCSS id を持つ事を前提にしている
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end
		end

		describe "for sign-in users" do
			let(:user) { FactoryGirl.create(:user) }
			before do
				FactoryGirl.create(:micropost, user: user, content: "Lorem")
				FactoryGirl.create(:micropost, user: user, content: "Ipsum")
				sign_in user
				visit root_path
			end

			it "should render the user's feed" do
				user.feed.each do |item|
					expect(page).to have_selector("li##{item.id}", text: item.content)
				end
			end

			describe "follower/following counts" do
				let(:other_user) { FactoryGirl.create(:user) }
				before do
					other_user.follow!(user)
					visit root_path
				end

				it { should have_link("0 following", href: following_user_path(user)) }
				it { should have_link("1 followers", href: followers_user_path(user)) }

			end
		end
	end

	describe "Help page" do
		before {visit help_path}
		let(:heading)   { 'Help' }
		let(:page_title){ heading }

		it_should_behave_like "all static pages"
	end

	describe "About page" do
		before {visit about_path}
		let(:heading)   { 'About Us' }
		let(:page_title){ heading }

		it_should_behave_like "all static pages"
	end

	describe "Contact page" do
		before {visit contact_path}
		let(:heading)   { 'Contact' }
		let(:page_title){ heading }

		it_should_behave_like "all static pages"
	end

	# レイアウトのリンクをテストする
	it "expect have the right links on the layout" do
		visit root_path
		click_link "About"
		should have_title(full_title('About Us'))
		click_link "Help"
		should have_title(full_title('Help'))
		click_link "Home"
		click_link "Sign up now!"
		should have_title(full_title('Sign up'))
		click_link "sample app"
		should have_title(full_title(''))
	end

end
