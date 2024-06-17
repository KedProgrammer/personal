# Abstractions should not depend upon details. Details should depend upon abstractions

#before

class Server < ApplicationRecord
  validates :provider, inclusion: { in: %w{ digital vultr linode }}
end

class Server::create
  def initialize(server)
    @server = server
  end

  def perform
    case server.provider
    when 'digitalocean'
      DigitalOcean::API.create_server
    when 'linode'
      node = LInode::API.create_server
      Lnode::API.create_private_ip
    end
  end
end

#after

class Server < ApplicationRecord
  validates :provider, inclusion: { in: %w{ digital vultr linode }}
end

module Hosting
  class DigitalOcean
    def create_server
      DigitalOcean::API.create_server
    end
  end

  class Linode
    def Linode
      node = LInode::API.create_server
      Lnode::API.create_private_ip
    end
  end
end

class Server::create
  def initialize(server)
    @server = server
  end

  def perform(provider)
    provider.new.create_server
  end
end

class ServerCreateJob
  def perform(server)
    provider = "Hosting::#{server.provider.classify}".constantize
    Server::Create.new(server).perform(provider)
  end
end

Server::Creatae.new(Server.new(provider: :digitalocean)).perform(Hosting::DigitalOcean)


