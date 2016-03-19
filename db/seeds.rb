# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
CSV.foreach(Rails.root.join("db/seed_data/adm.csv"), headers: true) do |row|
	if ENV["deseed"]
		User.where(name: row[0], email: row[1], crypted_password: row[2], admin: row[5]).destroy_all
	else
		User.create!(name: row[0], email: row[1], password: row[2], password_confirmation: row[3], bio: row[4], admin: row[5])
	end
end
