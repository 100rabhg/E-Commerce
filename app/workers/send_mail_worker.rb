class SendMailWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options retry: false
  recurrence { daily }

  def perform(user)
    UserMailer.welcome_mail(user).deliver_now
  end
end
