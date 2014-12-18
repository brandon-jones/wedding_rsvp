class AddFlagToGuestBook < ActiveRecord::Migration
  def change
  	add_column :guestbooks, :flag, :boolean
  end
end
