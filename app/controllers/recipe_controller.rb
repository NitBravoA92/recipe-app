class RecipeController < ApplicationController
	def index
		@user = current_user
		@recipes = Recipe.where(user_id: @user.id)
	end
end
