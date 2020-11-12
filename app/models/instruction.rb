class Instruction < ApplicationRecord
  MIN_INS_LENGTH = 3
  MAX_INS_LENGTH = 100

  belongs_to :recipe

  validates :order, presence: true, numericality: { only_integer: true, greater_than: 0 }

  validates :instruction_info, presence: true, length: { in: MIN_INS_LENGTH..MAX_INS_LENGTH }
end
