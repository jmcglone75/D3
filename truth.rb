require 'sinatra'
require 'sinatra/reloader'

# If a GET request comes in at /, do the following

get '/' do
	erb :index
end

get '/display' do
	if params.length != 3 or params[:true] == nil or params[:false] == nil or params[:size] == nil
		status 404
		return erb :error
	end
	
	#check empty params and assign default values
	if params[:true] == ''
		params[:true] = 'T'
	end
	if params[:false] == ''
		params[:false] = 'F'
	end
	if params[:size] == ''
		params[:size] = '3'
	end

	#check validity of params
	if params[:true].length > 1 or params[:false].length > 1 or params[:size].to_i < 2 or params[:true] == params[:false]
		return erb :error
	end
	

	
		
	erb :display, :locals => { tru: params[:true], fls: params[:false], size: params[:size] }

end

# If we have an error
not_found do
	status 404
	erb :error
end
