class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]

  # GET /tickets or /tickets.json
  def index
    if params[:event_id]
      @tickets = Ticket.where(event_id: params[:event_id])
    else
      @tickets = Ticket.all
    end
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @events = Event.all
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create

    @ticket = Ticket.new(ticket_params)

    @ticket_event = Event.find(@ticket.event_id)

    if @ticket_event.capacity < 1
      puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      puts '!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'
      respond_to do |format|
        format.html { redirect_to '/tickets#index', notice: "Ticket was not created. Event is full.", allow_other_host: true, status: :unprocessable_entity }

      end
    else
      @ticket_event.capacity -= 1
      @ticket_event.save
      respond_to do |format|
        if @ticket.save
          format.html { redirect_to '/events#index', notice: "Ticket was successfully created.", allow_other_host: true }
        else
          format.html { redirect_to '/tickets#index', status: :unprocessable_entity }
          format.json { render json: @ticket.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @destroy_success = @ticket.destroy

    if @destroy_success
      @event = Event.find(@ticket.event_id)
      @event.capacity += 1
      @event.save
    end

    respond_to do |format|
      format.html { redirect_to tickets_path, status: :see_other, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:user, :category, :event_id)
    end
end
