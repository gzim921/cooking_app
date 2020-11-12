class Recipe < ApplicationRecord
  MIN_TITLE_LENGTH = 3
  MAX_TITLE_LENGTH = 40
  MAX_DESC_LENGTH = 200

  has_many :instructions, dependent: :destroy
  has_many :ingridients, dependent: :destroy

  accepts_nested_attributes_for :instructions, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :ingridients, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true, length: { in: MIN_TITLE_LENGTH..MAX_TITLE_LENGTH }
  validates :description, presence: true, length: { maximum: MAX_DESC_LENGTH }
  validates_associated :instructions, :ingridients
end
