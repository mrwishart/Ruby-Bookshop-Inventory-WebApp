require('sinatra')
require('sinatra/contrib/all') if development?
# also_reload('./models/*')

require_relative('../models/book')
require_relative('../models/genre')

# EDIT

get '/bookgenres/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/books'
  else
    @add_genres_list = @book.other_genres
    @delete_genres_list = @book.genres
    erb (:"bookgenres/edit")
  end
end

# UPDATE

post '/bookgenres/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/not_found'
  else
    @book.add_genre_by_id(params['add_genre'])
    @book.delete_genre_by_id(params['delete_genre'])
    redirect to 'bookgenres/'+ @book.id.to_s + '/edit'
  end
end
