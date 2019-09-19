class CreateSpreeWishedProducts < ActiveRecord::Migration[5.2]
  def self.up
    create_table :spree_wished_products do |t|
      t.references :user
      t.references :variant
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :spree_wished_products
  end
end
