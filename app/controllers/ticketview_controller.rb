class TicketviewController < ApplicationController
 
  def ticketno
   render :text => "test"
  end
  def view
   
   
    
    @hash_val = params[:id].to_s
    
    @ticket = Ticket.where(:hash_str => @hash_val ).first
    if @ticket != nil
    #puts "id val--"+@ticket.owner
    @raffle = Raffle.find(@ticket.raffle_id)
    @business = @raffle.business
    else
      redirect_to "/"
    end
  end
  
  def genticket
    
    
    hashstr = ""
    status = ''
    if params[:authenticity_token] != nil
      email = params[:ticketview][:email]
      raffle_id = params[:ticketview][:raffle_id]
      parent_ticket_id = params[:ticketview][:parent_ticket_id]
      
      userdata = User.where(email: email).first
      userid = 0 
      
      puts "userarr --"+userdata.inspect
      
      
      
      
      if userdata.nil? == false && userdata.id.to_s.empty? == false
        puts 'in if='+userdata.email
        userid = userdata.id
      else 
        puts 'in else' 
         @user = User.new
         @user.email = email
         earr = email.split('@')
         @user.password = '12345678'
         @user.password_confirmation = '12345678'
         @user.first_name = earr[0]
         @user.last_name = earr[0]
         
         @user.save
         userid = @user.id
      end   
        
      puts 'useriddd---'+userid.to_s
      
      if userid > 0
        
         @ticketinfo = Ticket.where(raffle_id:raffle_id , owner:userid , parent_ticket:parent_ticket_id ).first
        
         if @ticketinfo.nil? == false && @ticketinfo.id.to_s.empty? == false 
            hashstr = @ticketinfo.hash_str
            status = 'existing'
         else
           @newticket = Ticket.new
           
           @newticket.raffle_id = raffle_id  
           @newticket.owner = userid 
           @newticket.parent_ticket = parent_ticket_id 
           
           @newticket.save
           
           url = "http://"+request.domain+":"+ request.port.to_s+"/t/"+@newticket.id.to_s
           puts 'ticketurl -- '+url
           hashstr = genhash(url.to_s)
           status = 'new'
           if hashstr.to_s.length == 0
              @newticket.destroy(@newticket.id)
           else
              
              @newticket.update(hash_str: hashstr)
           end
         end
      
         
      end
        
      
    end
    
    
    
    render :json => '{"hash":"'+hashstr.to_s+'", "status":"'+status+'"}'
  end
  
   
  def genhash(url)
      # code
      require 'net/http'
     
       @API_KEY = "4bCVE5QxL1FBsCva33dMI" #Rails.application.config.ow_ly_key
       api_url = "http://ow.ly/api/1.1/url/shorten?apiKey=#{@API_KEY}&longUrl=#{url}"
      
      puts 'api_url--'+api_url
       result = Net::HTTP.get(URI.parse(api_url))
        
        puts "owly--result"+result.inspect
        
       hashstr = ActiveSupport::JSON.decode(result)
      
      @hash = ""
      
       hashstr["results"].each do |key, val|
         
         if key == 'hash'
           @hash = val
         end
         
       end
   
       return @hash
      
    end
  
end
