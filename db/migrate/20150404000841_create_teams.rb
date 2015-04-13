class CreateTeams < ActiveRecord::Migration
  def change
    
    create_table :teams, id: :uuid do |t|
      t.string :name
      t.string :slack_id
      t.timestamps null: false
    end
    
  end
end
