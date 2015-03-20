RSpec.describe WelcomeController do
  
  describe "GET index" do
    context "when user is authenticated" do
      it "has a 302 status code" do
        sign_in :user, FactoryGirl.create(:user)
        get :index, {}
        expect(response.status).to eq(302)
      end
      
      it "redirect view" do
        sign_in :user, FactoryGirl.create(:user)
        get :index, {}
        expect(response).to_not render_template("index")
      end
    end
    
    context "when user isn't authenticated" do
      it "has a 200 status code" do
        sign_in :user, User.new
        get :index, {}
        expect(response.status).to eq(200)
      end
      
      it "redirect view" do
        sign_in :user, User.new
        get :index, {}
        expect(response).to render_template("index")
      end
    end
  end
end