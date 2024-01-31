require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do
    it { should belong_to :tea}
    it { should belong_to :customer}
  end

  describe "validations" do
    it "should validate a subscription" do 
      tea = Tea.create!(title: "Blueberry", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
      customer = Customer.create!(first_name: "Jo", last_name: "Jackson", email: "jackson5@gmail.com", address: "123 Main Ave")

      subscription = Subscription.create!(title: "#{tea.title}", price: 22.50, frequency: "3 months", customer: customer, tea: tea, sub_status: 1)
      expect(subscription).to validate_presence_of(:title)
      expect(subscription).to validate_presence_of(:price)
      expect(subscription).to validate_presence_of(:frequency)
      expect(subscription).to validate_presence_of(:customer_id)
      expect(subscription).to validate_presence_of(:tea_id)
      expect(subscription).to validate_presence_of(:sub_status)
    end
  end
end