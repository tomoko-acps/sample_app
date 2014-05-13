require 'spec_helper'
require 'support/utilities'

describe "UserPages" do
	subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { expect have_content('Sign up') }
    it { expect have_title(full_title('Sign up')) }
  end

  describe "signup" do
  	before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

  describe "profile page" do
  	let(:user) { FactoryGirl.create(:user) }
  	# ユーザ変数を作成するためのコードに置き換える
  	before { visit user_path(user) }

  	it { expect have_content(user.name) }
  	it { expect have_title(user.name) }
  end
end
