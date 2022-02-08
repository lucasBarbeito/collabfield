require 'rails_helper'
include Warden::Test::Helpers
# The include Warden::Test::Helpers line is required in order to use login_as method. The method logs a user in.
RSpec.describe "new", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a root path' do
      get '/posts/new'
      expect(response).to redirect_to(root_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'renders a new template' do
      get '/posts/new'
      expect(response).to render_template(:new)
    end
  end

end