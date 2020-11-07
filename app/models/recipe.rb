class Recipe < ApplicationRecord
  has_many :instructions
  has_many :ingridients

  accepts_nested_attributes_for :instructions, allow_destroy: true
  accepts_nested_attributes_for  :ingridients, allow_destroy: true
end
