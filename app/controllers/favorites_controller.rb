#---
# Excerpted from "Modern Front-End Development for Rails",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/nrclient for more book information.
#---
class FavoritesController < ApplicationController
  def index
    if params[:count_only]
      render(partial: "favorites/count")
    end
  end

  def create
    @favorite = Favorite.create(user: current_user, concert_id: params[:concert_id])
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to favorites_path }
      format.json { head :no_content }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to favorites_path }
      format.json { head :no_content }
    end
  end

  private def favorite_params
    params.require(:concert_id)
  end
end
