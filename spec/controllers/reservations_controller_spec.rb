RSpec.describe ReservationsController do
  describe "GET index" do
    context "when user is authenticated" do
      it "has a 200 status code" do
        sign_in :user, FactoryGirl.create(:user)
        get :index, {}
        expect(response.status).to eq(200)
      end
    end
  end
  
  describe "POST create" do
    let(:booking_time) { Date.current.midday }
    let(:request_params) { { reservation: { booked_at: booking_time } } }
    let(:post_request) { post :create, request_params}
    
    before { @request.env['HTTP_ACCEPT'] = "application/json" }
    
    context "when slot is available" do
      it do 
        sign_in :user, FactoryGirl.create(:user)
        post_request
        expect(response.status).to eq(200)
      end
    end

    context "when slot is unavailable" do
      it do
        FactoryGirl.create(:reservation, booked_at: booking_time )
        sign_in :user, FactoryGirl.create(:user)
        post_request
        expect(response.status).to eq(422)
      end
    end
    
    context "without booked_at" do
      it do
        FactoryGirl.create(:reservation, booked_at: booking_time )
        sign_in :user, FactoryGirl.create(:user)
        request_params[:reservation].delete(:booked_at)
        post_request
        expect(response.status).to eq(422)
      end
    end
  end
  
  describe "PUT update" do
    let(:booking_time) { Date.current.midday }
    let(:reservation) { FactoryGirl.create(:reservation, booked_at: booking_time ) }
    let(:put_request) { put :update, id: reservation.id}
    
    before { @request.env['HTTP_ACCEPT'] = "application/json" }
    
    context "when reservation user is equals to current user" do
      it do 
        sign_in :user, reservation.user
        put_request
        expect(response.status).to eq(200)
      end
    end
    
    context "when reservation user isn't equals to current user" do
      it do 
        sign_in :user, FactoryGirl.create(:user)
        put_request
        expect(response.status).to eq(422)
      end
    end
  end
end