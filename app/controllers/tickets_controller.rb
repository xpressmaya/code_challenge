class TicketsController < ApplicationController
  before_action :set_ticket, only %i[show]

  def index
    @tickets = Ticket.all
  end
  
  def show
    render file: Rails.root.join('public', '404.html'), layout: false, status: :not_found unless @ticket
  end

  private

  def set_ticket
    @ticket = Ticket.find_by_id(params[:id])
  end
end
