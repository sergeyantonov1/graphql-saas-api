class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.integer :invitee_id
      t.string :invitee_type
      t.integer :invited_by_id, null: false
      t.integer :invited_by_type, null: false
      t.string :token, null: false
      t.datetime :accepted_at
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :invitations, %i(invitee_id invitee_type)
    add_index :invitations, %i(invited_by_id invited_by_type)
    add_index :invitations, :token
  end
end
