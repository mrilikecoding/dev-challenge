# API for getting records sorted by field and posting lines

class API < Grape::API

	format :json

	post 'records/:line' do
		line = params[:line]
		Database.add_line(line)
	end

	get 'records/:primary_field' do
		primary_field = params[:primary_field]
		Challenge.sort_people(primary_field, params[:sort_by])
		# Challenge.sort_people(primary_field)
	end

end
