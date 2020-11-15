require 'factory_bot_rails'

FactoryBot.create_list(:user, 10)

User.all.each do |user|
  FactoryBot.create(:recipe, user: user)
end

Recipe.all.each do |recipe|
  FactoryBot.create(:instruction, recipe: recipe)
  FactoryBot.create(:ingridient, recipe: recipe)
end
