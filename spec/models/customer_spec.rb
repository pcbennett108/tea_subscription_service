require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :subscriptions}
    it { should have_many(:teas).through(:subscriptions) }
  end

  describe "validations" do
    it "should validate a customer" do 
      customer = Customer.create!(first_name: "Jo", last_name: "Jackson", email: "jackson4@gmail.com", address: "123 Main Ave")
      expect(customer).to validate_presence_of(:first_name)
      expect(customer).to validate_presence_of(:last_name)
      expect(customer).to validate_presence_of(:email)
      expect(customer).to validate_presence_of(:address)
    end
  end
end