class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show update destroy ]

  def index
    @recipes = Queries::RecipeFilters.new(Recipe.all).call(search_params)
    render json: @recipes, status: :ok
  end

  def show
    render json: @recipe, status: :ok
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: @recipe
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def search_params
      params(:search).permit(:name, :category_name, :page_number, :per_page)
    end

    def recipe_params
      params(:recipe).permit(:name, :category_name, :instructions, :photo)
    end
end
