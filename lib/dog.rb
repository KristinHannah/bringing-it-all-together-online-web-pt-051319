class Dog 
  attr_accessor :name, :breed 
  attr_reader :id
  
  def initialize(name:, breed:, id: = NIL)
    @name = name
    @breed = breed 
    @id = id
  end
  end 

end 