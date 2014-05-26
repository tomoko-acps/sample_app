class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 複合インデックス、follower_idとfollowed_idを組み合わせた時の一意性を強制する
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
