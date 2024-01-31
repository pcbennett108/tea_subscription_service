require 'rails_helper'

describe "subscribe endpoint" do
  it "creates a subscription based on information sent from front-end" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    new_subscription = {
      tea_id: "#{tea1.id}",
      customer_id: "#{customer.id}",
      frequency: "3",
    }

    post "/api/v1/subscriptions", headers: headers, params: JSON.generate(new_subscription)

    expect(response).to be_successful 
    subscription = JSON.parse(response.body, symbolize_names: true)
    expect(subscription[:data]).to be_a Hash
    expect(subscription[:data][:id].to_i).to be_an Integer
    expect(subscription[:data][:type]).to eq("subscription")
    expect(subscription[:data][:attributes]).to be_a Hash
    expect(subscription[:data][:attributes][:title]).to eq("#{tea1.title} Subscription")
    expect(subscription[:data][:attributes][:sub_status]).to eq("Subscribed")
  end

  it "returns error if customer or tea id is not found - customer" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    new_subscription = {
      tea_id: "#{tea1.id}",
      customer_id: "11111111111",
      frequency: "3",
    }

    post "/api/v1/subscriptions", headers: headers, params: JSON.generate(new_subscription)
    expect(response).not_to be_successful 
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:error]).to eq("Customer id or Tea id incorrect")
  end

  it "returns error if customer or tea id is not found - tea" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    
    headers = {"CONTENT_TYPE" => "application/json"}
    new_subscription = {
      tea_id: "11111111111",
      customer_id: "1",
      frequency: "3",
    }
    
    post "/api/v1/subscriptions", headers: headers, params: JSON.generate(new_subscription)
    expect(response).not_to be_successful 
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:error]).to eq("Customer id or Tea id incorrect")
  end
end