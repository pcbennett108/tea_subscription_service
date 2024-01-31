require 'rails_helper'

RSpec.describe Tea, type: :model do
  describe "relationships" do
    it { should have_many :subscriptions}
    it { should have_many(:customers).through(:subscriptions) }
  end

  describe "validations" do
    it "should validate a tea" do 
      tea = Tea.create!(title: "Blueberry", description: "A scrumptious evening tea", temperature: 208, brew_time: 15, price: 20.0)
      expect(tea).to validate_presence_of(:title)
      expect(tea).to validate_presence_of(:description)
      expect(tea).to validate_presence_of(:temperature)
      expect(tea).to validate_presence_of(:brew_time)
      expect(tea).to validate_presence_of(:price)
    end
  end
end