class Api::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show update destroy ]

  def index
    @recipes = Recipe.all.with_attached_photo
    @recipes = RecipeFilters.new(@recipes, search_params).call if params[:search]

    if @recipes.empty?
      render json: "There's no recipe available at the moment. Try adding some recipes", status: :ok
    else
      render json: @recipes, status: :ok
    end
  end

  def show
    render json: @recipe, status: :ok
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
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
      params.require(:search).permit(:name, :category_name, :page_number, :per_page)
    end

    def recipe_params
      params.permit(:name, :category, :instructions, :preparation_time, :photo)
    end
end
