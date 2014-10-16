require 'spec_helper'

describe 'User Pages' do
  subject { page }

  describe 'Signup Page' do
    before { visit signup_path }
    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe 'Signup Process' do
    before { visit signup_path }
    let(:submit) { 'Create my account' }

    describe 'With invalid information' do
      it 'Should not create a user' do
        expect { click_button submit }.not_to change(User, :count)
      end

      describe 'After submission' do
        before { click_button submit }
        it { should have_content('error') }
      end
    end

    describe 'With valid information' do
      before do
        fill_in 'Name',                  with: 'Example User'
        fill_in 'Email',                 with: 'user@example.com'
        fill_in 'Password',              with: 'foobar'
        fill_in 'Password confirmation', with: 'foobar'
      end
      it 'Should create a user' do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      describe 'user is signed in after registering' do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end

      describe 'after submission' do
        before { click_button submit }
        it { should have_content('Welcome to the Sample App!') }
      end
    end
  end

  describe 'Profile page' do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

end

