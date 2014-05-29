class CommentsController < ApplicationController

	def create

	  @pin = Pin.find params[:pin_id]
	  @comment = @pin.comments.build
	  @comment.comment = params[:comment][:comment]
	  @comment.title = params[:comment][:title]



	  @comment.user_id = current_user.id

	  if @comment.save
	  flash[:notice] = "Successfully created comment."
	  redirect_to pin_path(@pin)
	  end

	end

	def destroy
	    @comment = Comment.find(params[:id])
	    @comment.destroy
	    redirect_to :back

    end



	def comment_params    
    params.require(:comment).permit(:title, :comment)
  end

end
