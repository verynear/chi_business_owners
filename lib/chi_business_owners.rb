require "chi_business_owners/version"
require 'unirest'

module ChiBusinessOwners
	class Business
	  attr_accessor :account_number, :doing_business_as_name, :owner_first_name, :owner_last_name, :owner_title

	  def initialize(business_hash)
	  	@account_number = business_hash["account_number"]
	  	@doing_business_as_name = business_hash["doing_business_as_name"]
	  	@owner_first_name = business_hash["owner_first_name"]
	  	@owner_last_name = business_hash["owner_last_name"]
	  	@owner_title = business_hash["owner_title"]
	  end

	  def self.all
	  	business_response = Unirest.get("https://data.cityofchicago.org/resource/cwcw-dfrk.json").body
	  	convert_array_to_objects(business_response)
	  end

	  def self.where(search_hash)
	  	search_string = convert_search_hash_to_string(search_hash)
	  	business_response = Unirest.get("https://data.cityofchicago.org/resource/cwcw-dfrk.json?#{search_string}").body
	  	convert_array_to_objects(business_response)
	  end

	  private

	  def self.convert_array_to_objects(business_array)
	  	collection = []
	  	business_array.each do |business_hash|
	  		collection << Business.new(business_hash)
	  	end
	  	collection
	  end

	  def self.convert_search_hash_to_string(search_hash)
	  	search_array = []
	  	search_hash.each do |key, value|
	  		search_array << "#{key}=#{value}"
	  	end
	  	search_array.join("&")
	  end

	end
end