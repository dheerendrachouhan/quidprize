json.array!(@raffles) do |raffle|
  json.extract! raffle, :id, :business_id, :target_url, :end_date, :prize_id, :status
  json.url raffle_url(raffle, format: :json)
end
