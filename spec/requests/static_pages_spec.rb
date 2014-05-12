require 'spec_helper'
require 'support/utilities'

describe "Static Page" do

	subject { page }
	describe "Home page" do
		before {visit root_path}
		it { expect have_content('Sample App')}
		it { expect have_title(full_title(''))}
		it { expect be_falsy have_title('| Home')} # 否定形の時
	end

	describe "Help page" do
		before {visit help_path}
		it {expect have_content('Help')}
		it {expect have_title(full_title('Help'))}
	end

	describe "About page" do
		before {visit about_path}
		it {expect have_content('About Us');}
		it {expect have_title(full_title('About Us'))}
	end

	describe "Contact page" do
		before {visit contact_path}
		it {expect have_content('Contact')}
		it {expect have_title(full_title('Contact'))}
	end

end
