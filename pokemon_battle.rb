# create a pokemon class

class Pokemon
  def initialize(name)
    @name = name
  end

  # all accessors
  attr_accessor :fainted, :type, :health, :name, :speed

  # pokemon can take damage, faint, or deal damage

  def faint
    self.fainted = true
  end

  def take_damage(damage)
    @health = @health - damage
    if @health < 1
      @health = 0
    end
    faint if @health < 1
  end

  def tackle(recipient)
    recipient.take_damage(1)
  end
end

# pokemon type classes
class Water_Pokemon < Pokemon
  def initialize(name)
    super(name)
    @type = "water"
    @speed = 2
    @health = 10
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
  def initialize(name)
    super(name)
    @type = "fire"
    @speed = 3
    @health = 9
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
  def initialize(name)
    super(name)
    @type = "grass"
    @speed = 1
    @health = 11
  end
  def vine_whip(recipient)
    if recipient.type == "water"
      recipient.take_damage(2)
    else
      recipient.take_damage(0.5)
    end
  end
end

class Npc
  def random_move_select
    [1, 2].sample
  end

  def random_pokemon_select
    [1, 2, 3].sample
  end
end

class Game_Engine
  def play
    # allowing the player to select a pokemon
    puts "\nWelcome! Which starter will you select?"
    puts "\n-> Bulbasaur \n-> Squirtle \n-> Charmander?"
    print "\n>> "
    pick = gets.chomp
    pick_available = false
    player_pick_number = 0

    # pick a valid pokemon please
    while pick_available == false
      if pick == "Bulbasaur"
        player_pokemon = Grass_Pokemon.new("Bulbasaur")
        player_pick_number = 1
        pick_available = true
      elsif pick == "Charmander"
        player_pokemon = Fire_Pokemon.new("Charmander")
        pick_available = true
        player_pick_number = 2
      elsif pick == "Squirtle"
        player_pokemon = Water_Pokemon.new("Squirtle")
        pick_available = true
        player_pick_number = 3
      else
        puts "\nPlease pick one of the available starter Pokemon."
        print ">> "
        pick = gets.chomp
      end
    end

    # make an NPC (our random move generator, essentially)
    npc = Npc.new
    # give the npc a pokemon; make sure the pokemon are not the same
    rng_pokemon_number = npc.random_pokemon_select

    while rng_pokemon_number == player_pick_number
      rng_pokemon_number = npc.random_pokemon_select
    end

    if rng_pokemon_number == 1
      rng_pokemon = Grass_Pokemon.new("Bulbasaur")
      puts "\nYour rival picked: Bulbasaur!"
    elsif rng_pokemon_number == 2
      rng_pokemon = Fire_Pokemon.new("Charmander")
      puts "\nYour rival picked: Charmander!"
    elsif rng_pokemon_number == 3
      rng_pokemon = Water_Pokemon.new("Squirtle")
      puts "\nYour rival picked: Squirtle!"
    end

    # defining two move making functions

    def npc_move(np, pp, rngp, rngn)
      if np.random_move_select == 1
        rngp.tackle(pp)
        puts "\n#{rngp.name} used Tackle!"
      elsif rngn == 1
        rngp.vine_whip(pp)
        puts "\n#{rngp.name} used Vine Whip!"
      elsif rngn == 2
        rngp.fire_spin(pp)
        puts "\n#{rngp.name} used Fire Spin!"
      else
        rngp.water_gun(pp)
        puts "\n#{rngp.name} used Water Gun!"
      end
      puts "#{pp.name}\'s health is now #{pp.health}!"
    end

    def player_move(pp, rngp, ppn)
      puts "\nPick a move! 1 for tackle, 2 for an elemental move!"
      print ">> "
      move_number = gets.chomp
      puts move_number
      if move_number == "1"
        pp.tackle(rngp)
        puts "\n#{pp.name} used Tackle!"
      elsif move_number == "2" && ppn == 1
        pp.vine_whip(rngp)
        puts "\n#{pp.name} used Vine Whip!"
      elsif move_number == "2" && ppn == 2
        pp.fire_spin(rngp)
        puts "\n#{pp.name} used Fire Spin!"
      elsif move_number == "2" && ppn == 3
        pp.water_gun(rngp)
        puts "\n#{pp.name} used Water Gun!"
      else
        puts "Sorry, not a valid move; tackling instead!"
        pp.tackle(rngp)
        puts "\n#{pp.name} used Tackle!"
      end
      puts "#{rngp.name}\'s health is now #{rngp.health}!"
    end

    # core battle loop
    while !(rng_pokemon.health < 1 || player_pokemon.health < 1)
      if rng_pokemon.speed > player_pokemon.speed
        npc_move(npc, player_pokemon, rng_pokemon, rng_pokemon_number)
        if player_pokemon.fainted
          puts "\n#{player_pokemon.name} fainted!\n"
          puts "You lost."
          break
        end
        player_move(player_pokemon, rng_pokemon, player_pick_number)
        if rng_pokemon.fainted
          puts "\n#{rng_pokemon.name} fainted!\n"
          puts "You won!"
          break
        end
      else
        player_move(player_pokemon, rng_pokemon, player_pick_number)
        if rng_pokemon.fainted
          puts "\n#{rng_pokemon.name} fainted!\n"
          puts "You won!\n"
          break
        end
        npc_move(npc, player_pokemon, rng_pokemon, rng_pokemon_number)
        if player_pokemon.fainted
          puts "\n#{player_pokemon.name} fainted!\n"
          puts "You have lost.\n"
          break
        end
      end
    end
  end
end

new_game = Game_Engine.new
new_game.play
