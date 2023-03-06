class CreateTags < ActiveRecord::Migration[7.0]
  def change
    create_table :tags do |t|
      t.string :name
      t.references :tagable , polymorphic: true
      t.timestamps
    end
  end
end
