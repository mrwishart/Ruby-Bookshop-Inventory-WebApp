require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('../models/book')
require_relative('../models/author')

# EDIT

get '/bookauthors/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/404'
  else
    @add_authors_list = @book.other_authors
    @delete_authors_list = @book.authors
    erb (:"bookauthors/edit")
  end
end

# UPDATE

post '/bookauthors/:id/edit' do
  @book = Book.find_by_id(params['id'])
  if @book.nil?
    redirect to '/404'
  else
    @book.add_author_by_id(params['add_author'])
    @book.delete_author_by_id(params['delete_author'])
    redirect to 'bookauthors/'+ @book.id.to_s + '/edit'
  end
end
