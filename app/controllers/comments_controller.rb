class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end

  def create
    @bookmark = Bookmark.find(params[:bookmark_id])
    @comment = @bookmark.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @bookmark, notice: 'Your comment was successfully created.' }
      else
        format.html { render 'bookmark/show' }
      end
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
    params.require(:comment).permit(:author_name, :author_email, :body)
  end
end
