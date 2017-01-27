Rails.application.routes.draw do
	get '/suggestions', to: 'products#search'
end
