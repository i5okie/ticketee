require "httparty"

token = "188d77280e189ba58a06f66dd3a23242"
url = "http://localhost:3000/api/projects/1/tickets/1.json"

response = HTTParty.get(url,
  headers: {
    "Authorization" => "Token token=#{token}"
  }
)

puts response.parsed_response