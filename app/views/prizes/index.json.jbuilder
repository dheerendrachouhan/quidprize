json.array!(@prizes) do |prize|
  json.extract! prize, :id, :description, :type, :amount, :winner, :status
  json.url prize_url(prize, format: :json)
end
