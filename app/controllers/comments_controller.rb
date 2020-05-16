class CommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.name
    @comment.save
    redirect_to item_path(@item)
  end

  def destroy
    @item = Item.find(params[:item_id])
    @comment = @item.comments.find(params[:id])
    @comment.destroy
    redirect_to item_path(@item)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
