class BookmarksController < ApplicationController

  before_action :set_bookmark, only: [:edit, :update, :destroy]

  #before_action :authenticate_user!, :except => [:index, :show]

  def index
    if params[:mine]
      @bookmarks = current_user.try(:bookmarks).page(params[:page]).order(:cached_votes_total => :desc)
    else
      @bookmarks = Bookmark.page(params[:page]).per(5).order(:cached_votes_total => :desc)
    end
  end

  def show
    @bookmark = Bookmark.find(params[:id])
    @comment = @bookmark.comments.build
  end

  def new
    @bookmark = current_user.bookmarks.new
  end

  def edit
  end

  def create
    @bookmark = current_user.bookmarks.new(bookmark_params)

    if @bookmark.save
      redirect_to @bookmark, notice: 'Bookmark was successfully created.'
    else
      render :new
    end
  end

  def update
    if @bookmark.update(bookmark_params)
      redirect_to @bookmark, notice: 'Bookmark was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @bookmark.destroy
    redirect_to bookmarks_url, notice: 'Bookmark was successfully destroyed.'
  end

  def upvote
    @bookmark = Bookmark.find(params[:id])
    @bookmark.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @bookmark = Bookmark.find(params[:id])
    @bookmark.downvote_by current_user
    redirect_to :back
  end


  private

  def set_bookmark
    @bookmark = current_user.bookmarks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bookmark_params
    params.require(:bookmark).permit(:user_id, :url, :title, :description, :votes)
  end
end
