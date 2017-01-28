Rails.application.routes.draw do
	get '/suggestions', to: 'products#suggest'
end
