require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  describe '#create' do
    let(:sample_json) do
      {
        "RequestNumber": "123456",
        "SequenceNumber": "789",
        "RequestType": "Sample Request",
        "RequestAction": "Sample Action",
        "DateTimes": {
          "ResponseDueDateTime": "2023-06-16T10:00:00Z"
        },
        "ServiceArea": {
          "PrimaryServiceAreaCode": {
            "SACode": "PSC001"
          },
          "AdditionalServiceAreaCodes": [
            {
              "SACode": "ASC001"
            }
          ]
        },
        "ExcavationInfo": {
          "DigsiteInfo": {
            "WellKnownText": "POINT (10 20)"
          }
        },
        "Excavator": {
          "CompanyName": "Sample Company",
          "Address": "Sample Address",
          "City": "Sample City",
          "State": "Sample State",
          "Zip": "12345",
          "CrewOnsite": true
        }
      }
    end

    it 'creates a ticket with excavator and returns success response' do
      post :create, params: sample_json
      expect(response).to have_http_status(:ok)

      # Additional expectations based on your implementation
      expect(Ticket.count).to eq(1)
      expect(Excavator.count).to eq(1)
      expect(JSON.parse(response.body)['message']).to eq('Excavator Saved successfully')
    end

    it 'returns an error response if excavator creation fails' do
      # Simulate excavator creation failure
      allow_any_instance_of(Ticket).to receive(:create_excavator).and_return(nil)

      post :create, params: sample_json
      expect(response).to have_http_status(:unprocessable_entity)

      # Additional expectations based on your implementation
      expect(Ticket.count).to eq(0)
      expect(Excavator.count).to eq(0)
      expect(JSON.parse(response.body)['error']).to eq('Excavator creation failed error message')
    end

    it 'returns an error response if ticket creation fails' do
      # Simulate ticket creation failure
      allow(Ticket).to receive(:create).and_return(double('ticket', valid?: false, errors: { objects: [double('error', full_message: 'Ticket creation failed error message')] }))

      post :create, params: sample_json
      expect(response).to have_http_status(:unprocessable_entity)

      # Additional expectations based on your implementation
      expect(Ticket.count).to eq(0)
      expect(Excavator.count).to eq(0)
      expect(JSON.parse(response.body)['error']).to eq('Ticket creation failed error message')
    end
  end
end
