class CreateRsvps < ActiveRecord::Migration
  def change
    create_table :rsvps do |t|
      t.string :name
      t.string :contact
      t.boolean :attending
      t.integer :party_size, :default => 0

      t.timestamps
    end
  end
end
