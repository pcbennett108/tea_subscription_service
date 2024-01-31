# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 25.0)
tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 26.00)
customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")

subscription = Subscription.create!(title: "Blueberry Green Tea", price: "#{tea1.price}", frequency: "3 months", customer: customer, tea: tea1, sub_status: 1)