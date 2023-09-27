class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.string :name, null: false, default: ''
      t.text :comment, null: false, default: ''
      t.references :post, foreign_key: { on_delete: :cascade }, null: false

      t.timestamps
    end
  end
end
