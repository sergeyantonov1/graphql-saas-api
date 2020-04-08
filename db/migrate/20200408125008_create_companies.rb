# frozen_string_literal: true

class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.references :user,  null: false, foreign_key: { on_delete: :cascade }
    end
  end
end
