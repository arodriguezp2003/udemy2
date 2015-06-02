class RecipesController < ApplicationController
    def index
        respond_to do |format|
            @recipes = Recipe.all
            format.html # show.html.erb
            format.json { render json: @recipes }
        end
       
    end
    
    def show
        respond_to do | format|
            @recipe = Recipe::find(params[:id])
            format.html # show.html.erb
            format.json { render json: @recipe }
            
        end
    end
    
    def new
        @recipe = Recipe.new
    end
    def create
        @recipe = Recipe.new(recipe_param)
        @recipe.chef = Chef.find(1)
        
 
        if @recipe.save
            flash[:success] = "Your Recipe was created succesfully"
            redirect_to recipes_path
        else
            render :new
        end
    end
    def edit
        @recipe = Recipe.find(params[:id])
    end
    
    def update
        @recipe = Recipe.find(params[:id])

        if @recipe.update(recipe_param)
            flash[:success] = "Your Recipe was Edit succesfully"
            redirect_to recipe_path(@recipe)
        else
            render :new
        end
    end
    
    private
        
        def recipe_param
            params.require(:recipe).permit(:name,:summary,:description,:picture)
        end
end
