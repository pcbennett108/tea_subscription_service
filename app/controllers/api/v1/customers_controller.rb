class Api::V1::CustomersController < ApplicationController
  def create
    new_customer = Customer.new(customer_params)
    if new_customer.save
      render json: CustomerSerializer.new(new_customer), status: :created
    else
      render json: { error: new_customer.errors.full_messages}, status: :unprocessable_entity
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :address)
  end
end