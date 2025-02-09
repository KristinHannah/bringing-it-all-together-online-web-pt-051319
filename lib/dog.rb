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
        INSERT INTO dogs (name, breed)
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
    dog = self.new(hash)
    dog.save
  end 

  def self.new_from_db(row)
    id = row[0]
    name = row[1]
    breed = row[2]
    dog = self.new(name: name, breed: breed, id: id)
    dog
  end 
  
  def self.find_by_id(id)
    sql = "SELECT * FROM dogs WHERE id = ?"
    row = DB[:conn].execute(sql, id)[0]
    self.new_from_db(row)
  end 
  
  def self.find_or_create_by(name:, breed:)
    dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
    if !dog.empty?
      dog_data = dog[0]
      dog = Dog.new(name: dog_data[1], breed: dog_data[2], id: dog_data[0])
    else
      dog = self.create(name: name, breed: breed)
    end
    dog
  end 
  
  def Dog::find_by_name(name)
    sql = "SELECT * FROM dogs WHERE name = ?;"
    row = DB[:conn].execute(sql, name)[0]
    self.new_from_db(row)
  end 
  
end 