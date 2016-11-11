class CreateLearningMaterials < ActiveRecord::Migration[5.0]
  def change
    create_table :learning_materials do |t|
      t.references :node, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
