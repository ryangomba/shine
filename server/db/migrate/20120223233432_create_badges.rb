class CreateBadges < ActiveRecord::Migration
  def change

    create_table :badges do |t|
      t.string :ua_id
      t.string :latitude
      t.string :longitude
      
      t.datetime :last_push
      t.integer :next_job
      
      t.timestamps
    end

  end
end
