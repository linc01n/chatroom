class AddDefaultToMessage < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :user, :string, default: 'Anonymous'
  end
end
