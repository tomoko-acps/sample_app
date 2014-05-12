require 'spec_helper'
require 'support/utilities'

describe "UserPages" do
	subject { page }
  describe "signup page" do
  	before { visit signup_path}

  	it { expect have_content('Sign up') }
  	it { expect have_title(full_title('Sign up')) }
  end
end
