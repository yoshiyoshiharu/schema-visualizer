Rails.application.config.filter_parameters += [
  :passw, :secret, :token, :crypt, :salt, :certificate, :otp, :ssn
]
