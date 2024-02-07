class Recaptcha
  def self.valid?(token:)
    recaptcha_response = Faraday.post(
      'https://www.google.com/recaptcha/api/siteverify',
      {
        secret: ENV['GOOGLE_RECAPTCHA_SECRET_KEY'],
        response: token
      }
    )

    parsed_response = JSON.parse(recaptcha_response.body)

    parsed_response['success']
  end
end