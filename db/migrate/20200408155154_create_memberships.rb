class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.string :role, null: false

      t.timestamps
    end

    add_index :memberships, %i(user_id company_id), unique: true
  end
end
