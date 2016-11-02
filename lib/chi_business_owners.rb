require "chi_business_owners/version"

module ChiBusinessOwners
	class Business
	  attr_accessor :account_number, :doing_business_as_name, :owner_first_name, :owner_last_name, :owner_title

	  def initialize(hash)
	  	@account_number = hash["account_number"]
	  	@dba_name = hash["doing_business_as_name"]
	  	@first_name = hash["owner_first_name"]
	  	@last_name = hash["owner_last_name"]
	  	@owner_title = hash["owner_first_name"]
	  end

	  def self.find(account_number)
	  	Business.new(Unirest.get("https://data.cityofchicago.org/resource/cwcw-dfrk.json?account_number=#{params[:account_number]}").body)
	  end

	  def self.all
	  	collection = []
	  	Unirest.get("https://data.cityofchicago.org/resource/cwcw-dfrk.json").body.each do |business_hash|
	  		collection << Business.new(business_hash)
	  	end
	  	collection
	  end
	end
end
