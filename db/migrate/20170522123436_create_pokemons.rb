class CreatePokemons < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :content
      t.string :num
      t.string :image
      t.timestamps null: false
    end
  end
end
