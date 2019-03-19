# create a pokemon class

class Pokemon
  def initialize(name, health)
    @name = "#{name}"
    @health = health
  end

  # all accessors
  attr_accessor :fainted, :type, :health, :name

  # pokemon can take damage, faint, or deal damage

  def faint
    puts self.health
    puts "#{self.name} has fainted."
    self.fainted = true
  end

  def take_damage(damage)
    @health = @health - damage
    faint if @health < 1
  end

  def tackle(recipient)
    recipient.take_damage(1)
  end
end

# pokemon type classes
class Water_Pokemon < Pokemon
  def initialize(name, health)
    super(name, health)
    @type = "water"
  end
  def water_gun(recipient)
    if recipient.type == "fire"
      recipient.take_damage(2)
    else
      recipient.take_damage(0.5)
    end
  end
end

class Fire_Pokemon < Pokemon
  def initialize(name, health)
    super(name, health)
    @type = "fire"
  end
  def fire_spin(recipient)
    if recipient.type == "grass"
      recipient.take_damage(2)
    else
      recipient.take_damage(0.5)
    end
  end
end

class Grass_Pokemon < Pokemon
  def initialize(name, health)
    super(name, health)
    @type = "grass"
  end
  def vine_whip(recipient)
    if recipient.type == "water"
      recipient.take_damage(2)
    else
      recipient.take_damage(0.5)
    end
  end
end

# create the pokemon
squirtle = Water_Pokemon.new("Squirtle", 5)
charmander = Fire_Pokemon.new("Charmander", 5)

squirtle.water_gun(charmander)
puts charmander.health
squirtle.tackle(charmander)
puts charmander.health
squirtle.water_gun(charmander)
