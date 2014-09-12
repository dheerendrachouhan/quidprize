class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
  require 'net/http'
  helper_method :get_counts
  # GET /tickets
  # GET /tickets.json
  def index
    #@tickets = Ticket.includes(:user, :raffle =>[:business]).where(:owner => current_user.id, :business.user_id => current_user.id)
  
   @tickets = Ticket.joins(:raffle, :business).where(" tickets.owner=#{current_user.id} or businesses.user_id=#{current_user.id} ")
  
  end

  # GET /tickets/1
  # GET /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end
  
 

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url, notice: 'Ticket was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   
    def get_counts(hash)
      
    
       @API_KEY = Rails.application.config.ow_ly_key
      # puts 'key--'+@API_KEY
       api_url = "http://ow.ly/api/1.1/url/clickStats?apiKey=#{@API_KEY}&shortUrl=http://ow.ly/#{hash}"
    
       result = Net::HTTP.get(URI.parse(api_url))
        
       # puts 'result data--'+result
        
       infostr = ActiveSupport::JSON.decode(result)
      
       @click_count = 0
       
         if infostr["results"].empty? == false 
           infostr["results"].each do |key| 
              @click_count += key['clickCount'].to_i 
            end
         end
    
    return @click_count
      
    end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:raffle_id, :owner, :hash, :parent_ticket)
    end
    
    
 
end
