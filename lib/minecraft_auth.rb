require "minecraft_auth/version"
require 'httparty'

module MinecraftAuth
  PROTOCOL = "https://"
  BASE_URL = "authserver.mojang.com"
  ENDPOINT = "/authenticate"

  def self.account(user, pass)
    Account.new(user, pass)
  end

  def self.username_to_uuid(username)
    response = HTTParty.post("https://api.mojang.com/profiles/minecraft",
      :body => [username].to_json,
      :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
      )
    if response.length >= 1
      return response[0]["id"]
    else
      return nil
    end
  end

  class Account
    attr_reader :username
    attr_reader :password
    attr_reader :access_token
    attr_reader :client_token
    attr_reader :profiles

    def initialize(username, password)
      @username = username
      @password = password

      response = HTTParty.post("#{PROTOCOL}#{BASE_URL}#{ENDPOINT}",
        :body => {
          :"agent" => {
            :"name" => "Minecraft",
            :"version" => 1
            },
            :"username" => "#{@username}",
            :"password" => "#{@password}"
            }.to_json,
            :headers => { 'Content-Type' => 'application/json', 'Accept' => 'application/json'}
            )
      # No Error
      if not response['error']
        @access_token = response['accessToken']
        @client_token = response['clientToken']
        raw_profiles = response['availableProfiles']
        raw_selected = response['selectedProfile']
        @profiles = Array.new
        raw_profiles.each do |profile|
          selected = raw_selected['name'] == profile['name'] and raw_selected['id'] == profile['id']
          @profiles << Profile.new(profile['name'], profile['id'], selected)
        end
      # Error in response  
    else
      raise AccountError, response["errorMessage"]
    end
  end
end

class Profile
  attr_reader :name
  attr_reader :id
  attr_reader :selected

  def initialize(name, id, selected)
    @id = id
    @name = name
    @selected = selected
  end
end

class AccountError < StandardError
  def initialize(message)
    super()
  end
end
end
