class Ingridient < ApplicationRecord
  MIN_NAME_LENGTH = 2
  MAX_NAME_LENGTH = 40

  before_create :capitalize_name

  belongs_to :recipe

  validates :name, presence: true, length: { in: MIN_NAME_LENGTH..MAX_NAME_LENGTH }

  private

  def capitalize_name
    self.name = name.capitalize
  end
end
