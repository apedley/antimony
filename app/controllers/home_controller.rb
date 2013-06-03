class HomeController < ApplicationController
  def index
    @galleries = Gallery.public.limit(8)
    @photos = Photo.public.limit(24)
  end
end
