require 'rails_helper'

describe "subscriptions update endpoint" do
  it "updates a description status" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    subscription = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea1, customer: customer, sub_status: 1)
    
    headers = {"CONTENT_TYPE" => "application/json"}
    subscription_update = {
      subscription_id: "#{subscription.id}",
      subscription: false,
      message: "cancel subscription"
    }

    expect(subscription.sub_status).to eq("Subscribed")

    put "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription_update)
    
    expect(response).to be_successful 
    update = JSON.parse(response.body, symbolize_names: true)
    
    expect(update[:data]).to be_a Hash
    expect(update[:data][:id].to_i).to be_an Integer
    expect(update[:data][:type]).to eq("subscription")
    expect(update[:data][:attributes]).to be_a Hash
    expect(update[:data][:attributes][:title]).to eq("#{tea1.title} Subscription")
    expect(update[:data][:attributes][:sub_status]).to eq("Cancelled")

    subscription_update = {
      subscription_id: "#{subscription.id}",
      subscription: true,
      message: "cancel subscription"
    }

    put "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription_update)
    expect(response).to be_successful 
    update = JSON.parse(response.body, symbolize_names: true)
    
    expect(update[:data]).to be_a Hash
    expect(update[:data][:id].to_i).to be_an Integer
    expect(update[:data][:type]).to eq("subscription")
    expect(update[:data][:attributes]).to be_a Hash
    expect(update[:data][:attributes][:title]).to eq("#{tea1.title} Subscription")
    expect(update[:data][:attributes][:sub_status]).to eq("Subscribed")
  end

  

  it "update subscription - error message" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    subscription = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea1, customer: customer, sub_status: 1)

    headers = {"CONTENT_TYPE" => "application/json"}
    subscription_update = {
      subscription_id: "1111111111",
      subscription: false,
      message: "cancel subscription"
    }

    put "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription_update)
    
    expect(response).not_to be_successful 
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:error]).to eq("Subscription not found")
  end
end