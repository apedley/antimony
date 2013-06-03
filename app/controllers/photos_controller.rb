class PhotosController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create ]
  def new
    @photo = Photo.new(:public => true)
    @user_galleries = current_user.galleries
  end
  
  def create
    @photo = Photo.new(params[:photo])
    
    @photo.user = current_user
    if @photo.save
      redirect_to user_photos_path(current_user)
    else
      @user_galleries = current_user.galleries
      render 'new'
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def index
    @photos = Photo.public.page(params[:page])
  end

  def destroy
    @photo = Photo.find(params[:id])
    if @photo.user == current_user
      @photo.destroy
      redirect_to user_photos_path(current_user), :flash => { :notice => 'Photo deleted' }
    else
      redirect_to root_path, :flash => { :alert => 'Not authorized' }
    end
  end

  def edit
    @photo = Photo.find(params[:id])
    unless @photo.user == current_user
      redirect_to root_path, :flash => { :alert => 'Not authorized' }
    end
  end

  def update
    @photo = Photo.find(params[:id])
    if @photo.user == current_user
      @photo.update_attributes(params[:photo])
      redirect_to edit_photos_path(current_user)
    else
      redirect_to root_path, :flash => { :alert => 'Not authorized' }
    end
  end
end
