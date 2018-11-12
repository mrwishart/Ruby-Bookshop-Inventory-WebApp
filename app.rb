require('sinatra')
require('sinatra/contrib/all') if development?
also_reload('./models/*')

require_relative('./controllers/author_controller')
require_relative('./controllers/book_controller')
require_relative('./controllers/genre_controller')
require_relative('./controllers/wholesaler_controller')

# Index

get '/' do
  erb(:test)
end

error 404 do
  erb(:'404')
end

set :default_currency_unit, '&pound;'
set :default_currency_precision, 2
set :default_currency_separator, ' '
