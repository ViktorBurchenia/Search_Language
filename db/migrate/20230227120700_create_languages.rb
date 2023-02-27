class CreateLanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :language_type
      t.string :designed_by

      t.timestamps
    end
  end
end
