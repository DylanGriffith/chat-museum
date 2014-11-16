class AddChannelNameToMessage < ActiveRecord::Migration
  def up
    add_column :messages, :channel_name, :text
    execute "UPDATE messages SET channel_name=(SELECT channel_names[1]::text FROM servers WHERE servers.id = messages.server_id)"
  end

  def down
    remove_column :messages, :channel_name, :text
  end
end
