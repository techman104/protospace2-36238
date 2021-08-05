class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:index, :create, :new]
  before_action :redirect_root, except: :index
  
  def index
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments
  end  

  def edit
    @prototype = Prototype.find(params[:id])
  end  

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end  

  def destroy
    @prototype = Prototype.find(params[:id])
    if @prototype.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end  
  
  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
  
  def set_prototype
  end

  def redirect_root
    redirect_to root_path unless user_signed_in?
  end
  
  # def move_to_index
  #   unless user_signed_in?
  #     redirect_to action: :index
  #   end
  # end
end
