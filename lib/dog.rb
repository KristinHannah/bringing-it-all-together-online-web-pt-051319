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

end 