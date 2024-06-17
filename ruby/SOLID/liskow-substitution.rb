# If S is a subtype of T, then objects of type T in a program may be replaced with objects of type s without altering any of the desirable properties of that program


#before

class Bird
  def walk
  end

  def fly
  end

  def can_fly?
    true
  end
end

class Pigeon < Bird
end


class Cardinal < Bird
end

class Penguin < Bird
  def fly
    raise CannotFly
  end

  def can_fly?
    true
  end
end

def migrate_south
  birds.each do |bird|
    if bird.can_fly?
      bird.fly
    end
  end
end

# after

#before

class Bird
  def walk
  end
end

module Flying
  def fly
  end
end

class Pigeon < Bird
  include Flying
end


class Cardinal < Bird
  include Flying
end

class Penguin < Bird
end

def migrate_south
  birds.each do |bird|
    # enforce that all birds can fly
    if bird.can_fly?
      bird.fly
    end
  end
end