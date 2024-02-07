class Cliente < ApplicationRecord
  belongs_to :gimnasio
  attribute :imagen, :binary
end
