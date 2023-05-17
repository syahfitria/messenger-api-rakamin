class MessagesController < ApplicationController
  
  def create
    recipient = User.find(params[:user_id])
    conversation = Conversation.between(current_user.id, recipient.id)
    if conversation.nil?
      conversation = Conversation.create(sender_id: current_user.id, recipient_id: recipient.id)
    end
    message = ConversationMessage.create!(
      conversation: conversation, 
      user: current_user, 
      body: params[:message])

    data = {
      id: message.id,
      message: message.body,
      sender: {
        id: current_user.id,
        name: current_user.name
      },
      sent_at: message.created_at,
      conversation: {
        id: message.conversation_id,
        with_user: {
          id: recipient.id,
          name: recipient.name,
          photo_url: recipient.photo_url
        }
      }
    }
    json_response(data, :created)


  end
end