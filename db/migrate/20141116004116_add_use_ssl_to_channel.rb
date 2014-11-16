class AddUseSslToChannel < ActiveRecord::Migration
  def change
    add_column :channels, :use_ssl, :boolean, :default => false
  end
end
