# to generate short url from ow.ly
module Modules
  module GetTicketMod
    def genhash(url)
      # code
      require 'net/http'
     
       @API_KEY = Rails.application.config.ow_ly_key
       api_url = "http://ow.ly/api/1.1/url/shorten?apiKey=#{@API_KEY}&longUrl=#{url}"
      
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
end