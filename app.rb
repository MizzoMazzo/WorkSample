require 'sinatra'
require 'net/http'
require 'json'

get '/' do
    "Please use /trending for the requested Information"
end 

get '/trending' do

  # set content type to json
  content_type :json

  # url built with the help of official github search-api documentation: https://docs.github.com/en/free-pro-team@latest/rest/reference/search
  uri = URI('https://api.github.com/search/repositories?page=1&per_page=15&q=language:ruby&sort=stars&order=desc')

  # setup net/http and call the api
  Net::HTTP.start(uri.host, uri.port,
    :use_ssl => uri.scheme == 'https') do |http|
    request = Net::HTTP::Get.new uri
    response = http.request request
    JSON.pretty_generate(JSON.parse(response.body)) 
  end
end