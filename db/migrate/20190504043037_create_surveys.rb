class CreateSurveys < ActiveRecord::Migration[5.2]
  def change
    create_table :surveys do |t|
      t.text :title
      t.date :startDate
      t.date :endDate
      t.integer :status
      t.integer :totalVotes

      t.timestamps
    end
  end
end
