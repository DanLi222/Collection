class CommentsController < ApplicationController
  # Allow comment actions only when sign in
  before_action :authenticate_user!

  # Create comment for a specific item, add user_id and user_name to comment
  def create
    @item = Item.find(params[:item_id])
    @comment = @item.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comment.commenter = current_user.name
    @comment.save
    redirect_to item_path(@item)
  end

  # delete a comment
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
