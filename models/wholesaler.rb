require_relative('../db/sql_runner')

class Wholesaler

  attr_accessor :name, :address, :contact_number, :discount_offered
  attr_reader :id

  def initialize(params)
    @id = params['id'].to_i if params['id']
    @name = params['name']
    @address = params['address']
    @contact_number = params['contact_number'].to_s
    @discount_offered = params['discount_offered'].to_f.round(2)
  end

  # Class functions

  def self.all
    sql = "SELECT * FROM wholesalers ORDER BY id"
    results = SqlRunner.run(sql)
    return results.map {|wholesaler| Wholesaler.new(wholesaler)}
  end

  def self.delete_all
    sql = "DELETE FROM wholesalers"
    SqlRunner.run(sql)
  end

  def self.find_by_id(input_id)
    sql = "SELECT * FROM wholesalers WHERE id = $1"
    values = [input_id]
    result = SqlRunner.run(sql, values)
    return Wholesaler.new(result.first)
  end

  # Instance functions

  def save
    sql = "INSERT INTO wholesalers (name, address, contact_number, discount_offered) VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@name, @address, @contact_number, @discount_offered]
    new_id = SqlRunner.run(sql, values)
    @id = new_id[0]['id'].to_i
  end

  def update
    sql = "UPDATE wholesalers SET (name, address, contact_number, discount_offered) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @address, @contact_number, @discount_offered, @id]
    SqlRunner.run(sql, values)
  end

  def delete
    sql = "DELETE FROM wholesalers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  # Book functions

  def books
    sql = "SELECT books.*
    FROM books
    WHERE wholesale_id = $1
    ORDER BY title, edition"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|book| Book.new(book)}
  end

end
