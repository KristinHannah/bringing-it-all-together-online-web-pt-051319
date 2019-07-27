class Dog 
  attr_accessor :name, :breed 
  attr_reader :id
  
  def initialize(name: name, breed: breed, id: id = NIL)
    @name = name
    @breed = breed 
    @id = id
  end 

end 