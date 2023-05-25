class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  

def index
  @prototypes = Prototype.includes(:user)
end

def create
  @prototype = Prototype.new(prototype_params)
  if @prototype.save
    redirect_to root_path
  else
    render :new
  end
end

def new
  @prototype = Prototype.new
end

def show
  @prototype = Prototype.find(params[:id])
  @comment = Comment.new
  @comments = @prototype.comments.includes(:user)
end

def edit
  @prototype = Prototype.find(params[:id])
  unless current_user == @prototype.user
    redirect_to root_path
    return
  end
end

def update
  @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
end

def destroy
  @prototype = Prototype.find(params[:id])
  @prototype.comments.destroy_all
  @prototype.destroy
  redirect_to root_path
end

private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image, :content).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
