require_relative('../db/sql_runner')

class Book

  attr_accessor :description, :edition, :year_published
  attr_writer :title
  attr_reader :id

  def initialize (params)
    @id = params['id'].to_i if params['id']
    @title = params['title']
    @description = params['description']
    @edition = params['edition']
    @year_published = params['year_published'].to_i
  end

  # Class functions

  # Instance functions

  # Reader function

  def title
    return @title.downcase.capitalize
  end

end
