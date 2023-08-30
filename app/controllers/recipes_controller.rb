class RecipesController < ApplicationController
    def index
        if current_user
          recipes = Recipe.all.includes(:user)
          render json: recipes, include: :user
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end

    def create
        if current_user
          recipe = current_user.recipes.create(recipe_params)
          if recipe.valid?
            render json: recipe, include: :user, status: :created
          else
            render json: { error: recipe.errors.full_messages }, status: :unprocessable_entity
          end
        else
          render json: { error: 'Unauthorized' }, status: :unauthorized
        end
    end
    
    private
    
    def recipe_params
        params.require(:recipe).permit(:title, :instructions, :minutes_to_complete)
    end
end
