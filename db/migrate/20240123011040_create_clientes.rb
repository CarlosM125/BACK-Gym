class CreateClientes < ActiveRecord::Migration[7.0]
  def change
    create_table :clientes do |t|
      t.string :nombre
      t.string :apellido
      t.string :cedula
      t.string :email
      t.boolean :sub_activa
      t.datetime :fecha_sub
      t.binary :foto
      t.references :gimnasio, null: false, foreign_key: true

      t.timestamps
    end
  end
end
