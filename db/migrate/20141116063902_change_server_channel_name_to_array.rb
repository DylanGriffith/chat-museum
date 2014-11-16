class ChangeServerChannelNameToArray < ActiveRecord::Migration
  def up
    add_column :servers, :channel_names, :text, array: true, default: []
    execute "UPDATE servers SET channel_names=ARRAY[channel_name]"
    remove_column :servers, :channel_name, :text
  end

  def down
    remove_column :servers, :channel_names, :text, array: true, default: []
    add_column :servers, :channel_name, :text
  end
end
