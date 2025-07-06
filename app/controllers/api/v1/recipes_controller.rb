class Api::V1::RecipesController < ApplicationController
  before_action :set_recipe, only: %i[ show update destroy ]

  def index
    @recipes = Recipe.all.with_attached_photo
    @recipes = RecipeFilters.new(@recipes, search_params).call if params[:search]

    if @recipes.empty?
      render json: "There's no recipe available at the moment. Try adding some recipes", status: :ok
    else
      recipes_array = RecipeSerializer.new(@recipes).serializable_hash[:data].map { |d| d[:attributes] }
      render json: recipes_array, status: :ok
    end
  end

  def show
    render json: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes], status: :ok
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      render json: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes], status: :created
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def update
    if @recipe.update(recipe_params)
      render json: RecipeSerializer.new(@recipe).serializable_hash[:data][:attributes]
    else
      render json: @recipe.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @recipe.destroy
    render json: "Recipe successfuly removed", status: :ok
  end

  private

    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    def search_params
      params.require(:search).permit(:name, :category_name, :page_number, :per_page)
    end

    def recipe_params
      params.permit(:name, :category, :ingredients, :instructions, :preparation_time, :photo)
    end
end
