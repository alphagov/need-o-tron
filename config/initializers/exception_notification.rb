unless Rails.env.development? or Rails.env.test?
  NeedOTron::Application.config.middleware.use ExceptionNotifier,
    :email_prefix => "[Need-O-Tron] ",
    :sender_address => %{"Winston Smith-Churchill" <winston@alphagov.co.uk>},
    :exception_recipients => %w{dev@alphagov.co.uk}
end