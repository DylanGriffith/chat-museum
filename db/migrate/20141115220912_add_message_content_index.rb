class AddMessageContentIndex < ActiveRecord::Migration
  def up
    execute <<-SQL
    CREATE INDEX message_content_eng ON messages USING gin(to_tsvector('english', coalesce("messages"."content"::text, '')));
    SQL
  end

  def down
    execute "DROP INDEX message_content_eng"
  end
end
