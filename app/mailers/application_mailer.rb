class ApplicationMailer < ActionMailer::Base
  append_view_path Rails.root.join('app', 'views', 'mailers')
  default from: 'SliderUI <support@sliderui.com>'
  default reply_to: 'Steven <steven@happycode.llc>'
  layout 'mailer'
end
