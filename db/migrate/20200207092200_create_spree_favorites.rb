class CreateSpreeFavorites < ActiveRecord::Migration[5.2]
  def self.up
    create_table :spree_favorites do |t|
      t.references :user, null: false
      t.references :variant, null: false
      t.timestamps null: false
    end
    add_index :spree_favorites, [:user_id, :variant_id], unique: true
  end

  def self.down
    drop_table :spree_favorites
  end
end
