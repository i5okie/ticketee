class CommentsController < ApplicationController
  before_action :set_ticket

  def create
    whitelisted_params = sanitize_parameters!
    @comment = CommentWithNotifications.create(@ticket.comments,
                                                 current_user,
                                                 whitelisted_params)
    authorize @comment.comment, :create?

    if @comment.save
      flash[:notice] = "Comment has been created."
      redirect_to [@ticket.project, @ticket]
    else
      flash.now[:alert] = "Comment has not been created."
      @project = @ticket.project
      @comment = @comment.comment
      render "tickets/show"
    end
  end

  private
    def set_ticket
      @ticket = Ticket.find(params[:ticket_id])
    end

    def sanitize_parameters!
      whitelisted_params = comment_params

      unless policy(@ticket).change_state?
        whitelisted_params.delete(:state_id)
      end

      whitelisted_params
    end

    def comment_params
      params.require(:comment).permit(:text, :state_id, :tag_names)
    end
end
