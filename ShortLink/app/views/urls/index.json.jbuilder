json.array!(@urls) do |url|
  json.extract! url, :id, :description, :full_url, :short_url, :clicks, :user_id
  json.url url_url(url, format: :json)
end
