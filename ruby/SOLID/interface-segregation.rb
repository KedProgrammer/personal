# NO client should be forced to depend on methods it does not use
#before

class Server
  def add_ssh_key
  end
  
  def deploy
  end
end



class Provision < Script
  def perform
    key = '...'
    server.add_ssh_key(key)
  end
end

class App
  def deploy
    server.deploy(self)
  end
end

#after

class Server < ActiveRecord::Base
  
end

class AddSshKey
  def initialize(server)
    @server = server
  end

  def perform(key)
  end
end

class Deploy
  def initialize(server)
    @server = server
  end

  def perform(app)
  end
end


class Provision < Script
  def perform
    key = '...'
    AddSshKey.new(server).perform(key)
  end
end

class App < ActiveRecord::Base
  
end

Deploy.new(server).perform(app)


#example2

class Car
  def adjust_mirror
  end

  def drive
  end

  def d
    
  end
end