class Dog 
  attr_accessor :name, :breed 
  attr_reader :id
  
  def initialize(name: name, breed: breed, id: id = NIL)
    @name = name
    @breed = breed 
    @id = id
  end 
  
  def Dog::create_table 
    sql = <<-SQL 
    CREATE TABLE dogs (
    id INTEGER PRIMARY KEY, 
    name TEXT,
    breed TEXT
    );
    SQL
    
    DB[:conn].execute(sql)
  end 

  def Dog::drop_table 
    sql = "DROP TABLE dogs;"  
    
    DB[:conn].execute(sql)
  end 
  
  def save 
    if self.id
      self.update
    else
      sql = <<-SQL
        INSERT INTO songs (name, breed)
        VALUES (?, ?)
      SQL
 
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end 
    self
  end 
  
  def update
    sql = "UPDATE dogs SET name = ?, breed = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end

  
  def self.create(hash)
    hash.each {|key, value| self.send({"key" => "value"})}
  end 


end 