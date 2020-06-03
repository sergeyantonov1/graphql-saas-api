class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string :status
      t.string :stripe_subscription_id, index: true, unique: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
