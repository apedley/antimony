class GalleriesController < ApplicationController
  before_filter :authenticate_user!, :only => [ :new, :create, :edit, :update ]
  before_filter :find_gallery, :only => [:edit, :update, :show, :destroy]
  def index
    @galleries = Gallery.public.limit(16)
  end

  def show
    if @gallery.user == current_user
      @photos = @gallery.photos
    else
      @photos = @gallery.public_photos
    end
    respond_to do |type|
      type.html
      type.json { render :json => @gallery }
    end
  end

  def new
    @gallery = Gallery.new(:public => true)
    @photos = current_user.photos
  end

  def create
    @gallery = Gallery.new(params[:gallery])

    @gallery.user = current_user
    if @gallery.save
      redirect_to @gallery, :flash => { :notice => "Gallery was created" }
    else
      render 'new'
    end
  end

  def edit
    authenticate_owner!
  end

  def update
    authenticate_owner!

    if @gallery.update_attributes(params[:gallery])
      respond_to do |format|
        format.html { redirect_to @gallery, :flash => { :notice => 'Gallery Updated' } }
        format.json { render :json => @gallery}
      end
    else
      respond_to do |format|
        format.html { render :action => :edit }
        format.json { render :nothing => true }
      end
    end
  end 

  def destroy
    authenticate_owner!
    @gallery.destroy
    redirect_to user_galleries_path(current_user), :flash => { :notice => 'Gallery deleted' }
  end
  def add_photo
    @gallery = Gallery.find(params[:id])
    @photo = Photo.find(params[:photo])
    if @gallery.user == current_user
      unless @gallery.photos.include? @photo
        @gallery.photos << @photo
      end
    end
    respond_to do |format|
      format.html { redirect_to edit_gallery_path(@gallery) }
      format.json { render :error => 'access denied' }
    end
  end

  def remove_photo
    @gallery = Gallery.find(params[:id])
    @photo = Photo.find(params[:photo])
    if @gallery.user == current_user
      @gallery.photos.delete(@photo)
    end
    respond_to do |format|
      format.html { redirect_to edit_gallery_path(@gallery) }
      format.json { render :nothing => true }
    end
  end
  def authorize_current_user
    unless @gallery.user == current_user
      redirect_to root_path, :flash => { :alert => "Not authorized" }
    end
  end

  protected

  def find_gallery
    @gallery = Gallery.find(params[:id])
  end

  private
  def authenticate_owner!
    if current_user == @gallery.user
      return true
    end
    redirect_to root_path, :flash => { :alert => 'Not authorized' }
    return false
  end
end