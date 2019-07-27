class Dog 
  attr_accessor :name, :breed 
  attr_reader :id
  
  def initialize(dog_hash)
    dog_hash.each {|key, value| self.send(("#{key}="), value)}
  end 

end 