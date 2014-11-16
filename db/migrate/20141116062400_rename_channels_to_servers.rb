class RenameChannelsToServers < ActiveRecord::Migration
  def self.up
    rename_table :channels, :servers
    rename_column :messages, :channel_id, :server_id
  end

  def self.down
    rename_table :servers, :channels
    rename_column :messages, :server_id, :channel_id
  end
end
