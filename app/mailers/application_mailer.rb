class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'views', 'mailers')
  default from: 'SliderUI <hello@sliderui.com>'
  layout 'mailer'
end
