class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_mailbox
  before_action :get_conversation, except: [:index]
  before_action :get_box, only: [:index]


  def index
    if @boc.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end

    @conversations = @mailbox.inbox.paginate(page: params[:page], per_page: 10)
  end

  def show
  end

  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect _to conversation_path(@conversation)
  end

  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end
end
