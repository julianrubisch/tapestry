class CreateListMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :list_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :list, null: false, foreign_key: true
      t.boolean :may_comment, default: false
      t.boolean :may_edit, default: false

      t.timestamps
    end
  end
end
