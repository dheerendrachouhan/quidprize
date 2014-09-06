class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]
  attr_accessor :upload, :name
  # GET /businesses
  # GET /businesses.json
  def index
    @businesses = Business.all
    
  
  end

  # GET /businesses/1
  # GET /businesses/1.json
  def show
    @username = User.find(@business.user_id)
    
    @username = @username.first_name
  end

  # GET /businesses/new
  def new
    @business = Business.new
   
  end

  # GET /businesses/1/edit
  def edit
    
  end

  # POST /businesses
  # POST /businesses.json
  def create
   
   
   
  
    @business = Business.new(business_params)
 
   # puts "userid--"+"=="+params[:business][:user_id]
    
    uploaded_io = params[:business][:logo]
    if(uploaded_io !=nil )
    name =  uploaded_io.original_filename
    directory = "public/images"
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(uploaded_io.read) }
    end
    @business.logo = name ;
   # @business.user = params[:business][:user] #User.find(params[:business][:user]) ;
    respond_to do |format|
      if @business.save
        format.html { redirect_to @business, notice: 'Business was successfully created.' }
        format.json { render :show, status: :created, location: @business }
      else
        format.html { render :new }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /businesses/1
  # PATCH/PUT /businesses/1.json
  def update
    require 'pp'
    uploaded_io = params[:business][:logo]
    if(uploaded_io !=nil )
    name =  uploaded_io.original_filename
    directory = "public/images"
    path = File.join(directory, name)
    # write the file
    File.open(path, "wb") { |f| f.write(uploaded_io.read) }
     params[:business][:logo]  = name 
    else
     params[:business][:logo]  = params[:business][:logo_name] 
    end
   
    
   #p business_params[:logo]
    #business_params.logo = "tt"
    
    respond_to do |format|
      
      if @business.update(business_params)
        format.html { redirect_to @business, notice: 'Business was successfully updated.' }
        format.json { render :show, status: :ok, location: @business }
      else
        format.html { render :edit }
        format.json { render json: @business.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /businesses/1
  # DELETE /businesses/1.json
  def destroy
    
    File.delete("#{Rails.root}/public/images/#{@business.logo}")
    @business.destroy
    respond_to do |format|
      format.html { redirect_to businesses_url, notice: 'Business was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business
      @business = Business.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_params
      params.require(:business).permit(:name, :logo, :user_id)
    end
end
