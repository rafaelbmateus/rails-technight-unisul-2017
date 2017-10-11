class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :title
      t.string :description
      t.references :status, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
