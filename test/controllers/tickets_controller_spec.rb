require 'rails_helper'

RSpec.describe TicketsController, type: :controller do
  describe '#index' do
    it 'assigns all tickets and renders the index template' do
      tickets = create_list(:ticket, 3) # Assuming you have a factory set up for the Ticket model

      get :index
      expect(response).to have_http_status(:ok)
      expect(assigns(:tickets)).to eq(tickets)
      expect(response).to render_template(:index)
    end
  end

  describe '#show' do
    context 'when ticket exists' do
      let(:ticket) { create(:ticket) } # Assuming you have a factory set up for the Ticket model

      it 'assigns the requested ticket and renders the show template' do
        get :show, params: { id: ticket.id }
        expect(response).to have_http_status(:ok)
        expect(assigns(:ticket)).to eq(ticket)
        expect(response).to render_template(:show)
      end
    end

    context 'when ticket does not exist' do
      it 'renders the 404 page' do
        get :show, params: { id: 123 } # Assuming the ticket with ID 123 doesn't exist
        expect(response).to have_http_status(:not_found)
        expect(response).to render_template(file: Rails.root.join('public', '404.html'))
        expect(response).to render_template(layout: false)
      end
    end
  end
end
