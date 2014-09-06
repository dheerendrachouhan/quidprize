json.array!(@businesses) do |business|
  json.extract! business, :id, :name, :logo, :user
  json.url business_url(business, format: :json)
end
