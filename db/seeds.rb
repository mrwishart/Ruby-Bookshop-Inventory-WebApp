require_relative('../models/author')
require_relative('../models/book')
require_relative('../models/bookauthor')
require_relative('../models/bookgenre')
require_relative('../models/genre')
require_relative('../models/wholesaler')
require('pry-byebug')

Author.delete_all()
Genre.delete_all()

author1 = {"first_name" => "douGLas", "last_name" => "aDAMS"}
author2 = {"first_name" => "John", "last_name" => "Lloyd"}
author3 = {"first_name" => "John", "last_name" => "Wishart"}
author4 = {"first_name" => "Roger", "last_name" => "John"}

new_author1 = Author.new(author1)
new_author2 = Author.new(author2)
new_author3 = Author.new(author3)
new_author4 = Author.new(author4)

new_author1.save
new_author2.save
new_author3.save
new_author4.save

# new_author1.delete - Used to test delete instance function

# p Author.find_by_id(new_author1.id) - Used to test find_by_id class

genre1 = {"title" => "comedy"}
genre2 = {"title" => "HoRrOr"}
genre3 = {"title" => "Sci-fi"}
genre4 = {"title" => "coding manual"}

new_genre1 = Genre.new(genre1)
new_genre2 = Genre.new(genre2)
new_genre3 = Genre.new(genre3)
new_genre4 = Genre.new(genre4)

new_genre1.save
new_genre2.save
new_genre3.save
new_genre4.save

book1 = {"title" => "Hitchhiker's Guide To The Galaxy", "description" => "Seconds before the Earth is demolished to make way for a galactic freeway, Arthur Dent is plucked off the planet by his friend Ford Prefect, a researcher for the revised edition of The Hitchhiker's Guide to the Galaxy who, for the last fifteen years, has been posing as an out-of-work actor.

Together this dynamic pair begin a journey through space aided by quotes from The Hitchhiker's Guide ('A towel is about the most massively useful thing an interstellar hitchhiker can have') and a galaxy-full of fellow travelers: Zaphod Beeblebrox—the two-headed, three-armed ex-hippie and totally out-to-lunch president of the galaxy; Trillian, Zaphod's girlfriend (formally Tricia McMillan), whom Arthur tried to pick up at a cocktail party once upon a time zone; Marvin, a paranoid, brilliant, and chronically depressed robot; Veet Voojagig, a former graduate student who is obsessed with the disappearance of all the ballpoint pens he bought over the years", "edition" => "1st", "year_published" => "1979"}

book2 = {'title' => "The Bible", "description" => "It's the Bible. What else do you need to know?", "edition" => "88th", "year_published" => "1879"}

new_book1 = Book.new(book1)
new_book2 = Book.new(book2)

new_book1.save
new_book2.save

binding.pry
nil
