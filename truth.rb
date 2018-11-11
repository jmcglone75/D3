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
		return erb :invalid
	end

	#make array of true/false values
	#loop 2^n times (for each boolean expression of props)
	#loop n times (to determine and/or/xor)
	table = Array.new
	n = params[:size].to_i

	(2**n).times do |i|
		expression = Array.new
		logical_and = true
		logical_or = false
		logical_xor = false

		# permute truth/false values for each expression
		n.times do |j|
			if((i/(2**(n-j-1)))%2 == 1)
				logical_or = true
				logical_xor = !logical_xor
				expression << true
			else
				logical_and = false
				expression << false
			end
		end
		expression << logical_and
		expression << logical_or
		expression << logical_xor
		table << expression
	end
		
	erb :display, :locals => { tru: params[:true], fls: params[:false], size: params[:size], table: table}
end

# If we have an error
not_found do
	status 404
	erb :error
end
