json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :raffle, :owner, :hash, :parent_ticket
  json.url ticket_url(ticket, format: :json)
end
