class RafflesController < ApplicationController
  before_action :set_raffle, only: [:show, :edit, :update, :destroy]
  
 
  # GET /raffles
  # GET /raffles.json
  def index
    @raffles = Raffle.includes(:business).where({:businesses => {:user_id => current_user.id}})
  end

  # GET /raffles/1
  # GET /raffles/1.json
  def show
     @raffle.end_date= @raffle.end_date.strftime("%d-%m-%Y")
  end

  # GET /raffles/new
  def new
    @raffle = Raffle.new
  end

  # GET /raffles/1/edit
  def edit
    @raffle.end_date= @raffle.end_date.strftime("%d-%m-%Y")
    
  end

  # POST /raffles
  # POST /raffles.json
  def create
    require 'date'
    mydate = ((raffle_params[:end_date]).to_s).to_date
  # dates = mydate
   
   
   @raffle = Raffle.new(raffle_params)
    
    @hashval =  call_owly_service(raffle_params[:target_url])
  
    respond_to do |format|
      if @raffle.save
        
        create_ticket(@hashval, @raffle.id)
        format.html { redirect_to @raffle, notice: 'Raffle was successfully created.' }
        format.json { render :show, status: :created, location: @raffle }
      else
        format.html { render :new }
        format.json { render json: @raffle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /raffles/1
  # PATCH/PUT /raffles/1.json
  def update
    respond_to do |format|
      if @raffle.update(raffle_params)
        format.html { redirect_to @raffle, notice: 'Raffle was successfully updated.' }
        format.json { render :show, status: :ok, location: @raffle }
      else
        format.html { render :edit }
        format.json { render json: @raffle.errors, status: :unprocessable_entity }
      end
    end
  end
  
 def create_ticket(hashstr, raffle)
   
    @ticket = Ticket.new
    
    @ticket.raffle_id = raffle
    @ticket.owner = current_user.id
    @ticket.hash_str = hashstr
    @ticket.parent_ticket = 0
    
    @ticket.save
    
  end
  # DELETE /raffles/1
  # DELETE /raffles/1.json
  def destroy
    @raffle.destroy
    respond_to do |format|
      format.html { redirect_to raffles_url, notice: 'Raffle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  
    def set_raffle
      @raffle = Raffle.find(params[:id])
    end
   
    # Never trust parameters from the scary internet, only allow the white list through.
    def raffle_params
      params.require(:raffle).permit(:business_id, :target_url, :end_date, :prize_id, :status,  :contact_name, :contact_no)
    end
    
    def call_owly_service(url)
      require 'net/http'
     
     @API_KEY = Rails.application.config.ow_ly_key
     api_url = "http://ow.ly/api/1.1/url/shorten?apiKey=#{@API_KEY}&longUrl=#{url}"
    
     
      
     result = Net::HTTP.get(URI.parse(api_url))
      
      
     hashstr = ActiveSupport::JSON.decode(result)
    @hash = ""
    
    puts "hasstr--"+hashstr.inspect
    if hashstr["error"].nil? == true
     hashstr["results"].each do |key, val|
       
       if key == 'hash'
         @hash = val
       end
       
     end
    else
       
    end 
     
   #  puts "inloop--"+@hash
     return @hash
     # p hashstr[:results]
    end
end
