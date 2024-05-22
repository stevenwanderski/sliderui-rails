class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'views', 'mailers')
  default from: 'SliderUI <support@sliderui.com>'
  default reply_to: 'SliderUI <support@sliderui.com>'
  layout 'mailer'
end
