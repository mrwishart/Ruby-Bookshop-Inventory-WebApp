require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/author')

# INDEX

get '/authors' do
  @authors = Author.all()
  erb(:"authors/index")
end

# NEW

get '/authors/new' do
  erb(:"authors/new")
end

# CREATE

post '/authors' do
  Author.new(params).save
  redirect to '/authors'
end

# SHOW

get '/authors/:id' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    erb(:'404')
  else
    erb(:'authors/show')
  end
end

# EDIT

get '/authors/:id/edit' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    erb(:'404')
  else
    erb(:'authors/edit')
  end
end

# UPDATE

post '/authors/:id' do
  @author = Author.new(params)
  @author.update
  redirect to '/authors/' + @author.id.to_s
end

# DELETE

post '/authors/:id/delete' do
  @author = Author.find_by_id(params['id'])
  if @author.nil?
    redirect to '/404'
  else
    @author.delete
    redirect to '/authors'
  end
end
