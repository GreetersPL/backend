require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe Api::V1::WalksController, type: :controller do
  describe 'Api v1 walk' do
    describe 'POST /api/v1/walks' do
      it 'create walk' do
        post :create, format: :json, walk: FactoryGirl.attributes_for(:walk).as_json
        expect(response.status).to eq 201
        expect(JSON.parse(response.body).keys).to contain_exactly('id', 'name', 'email', 'dates', 'languages', 'created_at')
      end
    end
  end
end
