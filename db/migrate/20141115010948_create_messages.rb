class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :channel_id
      t.text :content
      t.text :author
      t.timestamps
      t.index :author
    end
  end
end
