class CreateTasks < ActiveRecord::Migration
  def change
    
    create_table :tasks, id: :uuid do |t|
      t.uuid :team_id
      t.uuid :player_id
      t.date :date

      t.string :category
      t.text :body

      t.timestamps null: false
    end

  end
end
