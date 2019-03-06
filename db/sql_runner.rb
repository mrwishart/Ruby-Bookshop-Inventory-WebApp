require( 'pg' )

class SqlRunner

  def self.run( sql, values = [] )
    begin
      db = PG.connect({ dbname: 'dckhg6r2igrhnb',
        host: 'ec2-54-75-230-41.eu-west-1.compute.amazonaws.com',
        port: '5432',
        user: 'mckuskmtfgrorh',
        password: '2f2245d4d9dcc99463f33da592814425932f9b70ff47ef426af0d58aff829fe7' })
      db.prepare("query", sql)
      result = db.exec_prepared( "query", values )
    ensure
      db.close() if db != nil
    end
    return result
  end

end
