# Every module or class should have responsability over a single part of the functionality
# and that responsability should be entirely encapsulated

#before

class server < ApplicationRecord
  has_many :app
  validates :name, presence: true

  def setup
    start_ssh @server self, as: "root" do |ssh|
      ssh.execute "apt install ruby"
      ssh.execute "git clone .."
    end
  end

  def deploy
    start_ssh self, as: "root" do |ssh|
      ssh.execute "cd repo"
      ssh.execute "git remote update"
      ssh.execute "tourch tmp/restart.txt"
  end

  def start_ssh as: "deploy", &block
    Net::SSH.start self.ip do |ssh|
      block.call ssh
    end
  end
end

#after

class App::Deploy
  def perform
    app.servers.each do |server|
      Server::Deploy.new(server).perform
    end
  end
end


class server < ApplicationRecord
  has_many :app
  validates :name, presence: true
end


class Server::Setup < Server::SSH
  def perform
    start_ssh @server self, as: "root" do |ssh|
      ssh.execute "apt install ruby"
      ssh.execute "git clone .."
    end
  end
end

class Server::Deploy < Server::SSH
  def deploy
    start_ssh self, as: "root" do |ssh|
      ssh.execute "cd repo"
      ssh.execute "git remote update"
      ssh.execute "tourch tmp/restart.txt"
  end
end


class Server::SSH
  def start_ssh as: "deploy", &block
    Net::SSH.start self.ip do |ssh|
      block.call ssh
    end
  end

  def logger
  end
end