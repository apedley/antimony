class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @photos = @user.photos
      @galleries = @user.galleries
    else
      @photos = @user.public_photos
      @galleries = @user.public_galleries
    end
  end

  def photos
    @user = User.find(params[:id])
    if @user == current_user
      @photos = @user.photos.processed.page(params[:page])
    else
      @photos = Kaminari.paginate_array(@user.public_photos.processed).page(params[:page]).per(36)
    end
  end
  def galleries
    @user = User.find(params[:id])
    if @user == current_user
      @galleries = @user.galleries
    else
      @galleries = @user.public_galleries
    end
  end

  def uncategorized
    @user = User.find(params[:id])
    if @user == current_user
      @photos = @user.uncategorized_photos
      
    else
      redirect_to root_url
    end
  end

  def edit_photos
    @user = User.find(params[:id])
    if @user == current_user
      @photos = @user.photos
    else
      redirect_to root_url
    end
  end
end