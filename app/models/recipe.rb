class Recipe < ApplicationRecord
  has_many :instructions
  accepts_nested_attributes_for :instructions, allow_destroy: true
end
