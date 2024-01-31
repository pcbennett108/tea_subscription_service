require 'rails_helper'

describe "subscribtion all endpoint" do
  it "shows all subscriptions cancelled or active" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    
    subscription = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea1, customer: customer, sub_status: 1)
    subscription1 = Subscription.create!(title: "Black Tea Subscription", price: 20.0, frequency: "3", tea: tea2, customer: customer, sub_status: 1)
    subscription2 = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea2, customer: customer, sub_status: 0)
    
    headers = {"CONTENT_TYPE" => "application/json"}

    customer_info = {customer_id: "#{customer.id}"}

    get "/api/v1/subscriptions", headers: headers, params: customer_info
    
    expect(response).to be_successful 
    subscriptions = JSON.parse(response.body, symbolize_names: true)
    
    expect(subscriptions[:data]).to be_an Array
    expect(subscriptions[:data].count).to eq(3)
    expect(subscriptions[:data][0][:id].to_i).to be_an Integer
    expect(subscriptions[:data][0][:type]).to eq("subscription")
    expect(subscriptions[:data][0][:id].to_i).to eq(subscription.id)
    expect(subscriptions[:data][1][:id].to_i).to eq(subscription1.id)
    expect(subscriptions[:data][2][:id].to_i).to eq(subscription2.id)
    expect(subscriptions[:data][0][:attributes][:title]).to eq("#{tea1.title} Subscription")
    expect(subscriptions[:data][0][:attributes][:sub_status]).to eq("Subscribed")
    expect(subscriptions[:data][2][:attributes][:title]).to eq("#{tea1.title} Subscription")
    expect(subscriptions[:data][2][:attributes][:sub_status]).to eq("Cancelled")
  end

  it "get all subscriptions - error message" do 
    tea1 = Tea.create!(title: "Blueberry Green Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    tea2 = Tea.create!(title: "Black Tea", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
    customer = Customer.create!(first_name: "Lisa", last_name: "Simpson", email: "lisa@gmail.com", address: "123 Fake St.")
    
    subscription = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea1, customer: customer, sub_status: 1)
    subscription1 = Subscription.create!(title: "Black Tea Subscription", price: 20.0, frequency: "3", tea: tea2, customer: customer, sub_status: 1)
    subscription2 = Subscription.create!(title: "Blueberry Green Tea Subscription", price: 20.0, frequency: "3", tea: tea2, customer: customer, sub_status: 0)

    headers = {"CONTENT_TYPE" => "application/json"}
    customer_info = {customer_id: "1111111111"}

    get "/api/v1/subscriptions", headers: headers, params: customer_info
    
    expect(response).not_to be_successful 
    error = JSON.parse(response.body, symbolize_names: true)
    expect(error[:error]).to eq("Incorrect customer id")
  end
end