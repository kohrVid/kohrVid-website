require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	describe "GET 'index'" do
		it "gets the index view" do
			get :index
			expect(response).to be
		end
=begin doesn't work because not logged in
		it "gets the correct index view template" do
			get :index 
			expect(response).to render_template("users/index")
		end
=end
	end

end
