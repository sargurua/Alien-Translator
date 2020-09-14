class CreateTranslations < ActiveRecord::Migration[6.0]
  def change
    create_table :translations do |t|
      t.string :english
      t.string :gorbyoyo

      t.timestamps
    end
  end
end
