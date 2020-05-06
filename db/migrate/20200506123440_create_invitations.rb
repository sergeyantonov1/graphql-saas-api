class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email, null: false
      t.integer :invitee_id
      t.string :invitee_type
      t.integer :sender_id, null: false
      t.string :sender_type, null: false
      t.string :token, null: false
      t.datetime :accepted_at
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end

    add_index :invitations, :token
    add_index :invitations, %i(email company_id)
    add_index :invitations, %i(invitee_id invitee_type)
    add_index :invitations, %i(sender_id sender_type)
  end
end
