class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @ticket = Ticket.create(ticket_params) ? build_excavator : render_ticket_error
  end
  
  private
  
  def build_excavator
    if excavator = @ticket.create_excavator(excavator_params)
      render json: { message: 'Excavator Saved successfully' }, status: :ok
    else
      @ticket.destroy
      render json: { error: excavator.errors.objects.first.full_message }
    end
  end

  def render_ticket_error
    render json: { error: @ticket.errors.objects.first.full_message }
  end

  def ticket_params
    {
     request_number: params[:RequestNumber],
     sequence_number: params[:SequenceNumber],
     request_type: params[:RequestType],
     request_action: params[:RequestAction],
     response_due_date_time: params.dig(:DateTimes, :ResponseDueDateTime),
     primary_service_area_code: params.dig(:ServiceArea, :PrimaryServiceAreaCode, :SACode),
     additional_service_area_code: params.dig(:ServiceArea, :AdditionalServiceAreaCodes, :SACode).first,
     well_known_text: params.dig(:ExcavationInfo, :DigsiteInfo, :WellKnownText)
    }
  end
  
  def excavator_params
    {
      company_name: params.dig(:Excavator, :CompanyName),
      crew_onsite: params.dig(:Excavator, :CrewOnsite),
      address: "#{params.dig(:Excavator, :Address)},
                #{params.dig(:Excavator, :City)},
                #{params.dig(:Excavator, :State)},
                #{params.dig(:Excavator, :Zip)}" 
    }
  end
end
