class CreateGimnasios < ActiveRecord::Migration[7.0]
  def change
    create_table :gimnasios do |t|
      t.string :nombre
      t.string :direccion
      t.string :telefono

      t.timestamps
    end
  end
end
