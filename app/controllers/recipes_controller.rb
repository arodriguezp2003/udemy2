class RecipesController < ApplicationController
    def index
        @recipes = Recipe::paginate(:page => params[:page], :per_page=> 4)
       
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
    
    def like
        @recipe = Recipe.find(params[:id])
        like = Like.create(likes: params[:like], chef: Chef.first, recipe: @recipe)
        if like.valid?
            flash[:success] = "Your Selection was Succesfull"
            redirect_to :back
        else
            flash[:danger] = "You can only like/deslike a recipe once"
            redirect_to :back
        end
        
    end
    private
        
        def recipe_param
            params.require(:recipe).permit(:name,:summary,:description,:picture)
        end
end
