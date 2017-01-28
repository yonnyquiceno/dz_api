require 'rails_helper'
require 'rspec_api_documentation'
require 'rspec_api_documentation/dsl'

RspecApiDocumentation.configure do |config|
  config.format = [:json]
  # config.curl_host = 'https://api.scorebooklive.com'
  config.api_name = 'Dentalzon'
  config.docs_dir = Rails.root.join('public/docs')
  config.request_headers_to_include = ["Host", "Content-Type"]
  config.response_headers_to_include = ["Host", "Content-Type"]
  config.curl_headers_to_filter = ['Cookie', 'Host']
  config.request_body_formatter = :json
end

def json
  header "Content-Type", "application/json"
end
