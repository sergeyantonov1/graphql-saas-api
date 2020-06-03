class AddStripeCustomerIdColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :stripe_customer_id, :string

    add_index :users, :stripe_customer_id, unique: true
  end
end
