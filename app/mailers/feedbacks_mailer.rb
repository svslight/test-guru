class FeedbacksMailer < ApplicationMailer

  def send_feedback(feedback)
    @user = feedback.user
    @body = feedback.body
  
    @admin = User.find_by(type: 'Admin')
    
    if @admin.present?
      mail(to: @admin.email)
    else
      redirect_to root_path, notice: 'Создайте администратора!'
    end
  end
end
