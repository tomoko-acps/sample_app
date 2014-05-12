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
		expect have_title(full_title('About Us'))
		click_link "Help"
		expect have_title(full_title('Help'))
		click_link "Home"
		click_link "Sign up now!"
		expect have_title(full_title('Sign up'))
		click_link "sample app"
		expect have_title(full_title(''))
	end

end
