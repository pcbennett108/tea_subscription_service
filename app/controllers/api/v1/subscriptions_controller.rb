class Api::V1::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find_by(id: params[:customer_id])
    if customer
      subscriptions = customer.subscriptions
      render json: SubscriptionSerializer.new(subscriptions), status: 200
    else
      render json: { error: 'Incorrect customer id'}, status: 404
    end
  end

  def create
    tea = Tea.find_by(id: params[:tea_id])
    customer = Customer.find_by(id: params[:customer_id])
    if customer && tea
      subscription = Subscription.create!(title: "#{tea.title} Subscription", price: tea.price, frequency: (params[:frequency]), tea: tea, customer: customer, sub_status: 1)
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      render json: { error: 'Customer id or Tea id incorrect'}, status: 404
    end
  end

  def update
    subscription = Subscription.find_by(id: params[:subscription_id])
    if subscription
      if params[:subscription] == false
        subscription.update_columns(sub_status: 0)
        render json: SubscriptionSerializer.new(subscription), status: 200
      else
        subscription.update_columns(sub_status: 1)
        render json: SubscriptionSerializer.new(subscription), status: 200
      end
    else
      render json: { error: 'Subscription not found'}, status: 404
    end
  end
end