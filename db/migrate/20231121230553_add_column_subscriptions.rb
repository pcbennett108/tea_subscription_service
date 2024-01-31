class AddColumnSubscriptions < ActiveRecord::Migration[7.1]
  def change
    add_column :subscriptions, :sub_status, :integer, default: 0
  end
end
