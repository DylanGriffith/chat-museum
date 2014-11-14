class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|
      t.text :name
      t.text :hostname
      t.text :channel_name
      t.text :password
      t.integer :port
      t.timestamps
    end
  end
end
