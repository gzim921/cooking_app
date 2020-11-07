class Recipe < ApplicationRecord
  has_many :instructions, dependent: :destroy
  has_many :ingridients, dependent: :destroy

  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for  :ingridients, allow_destroy: true
end
