Rails.application.config.filter_parameters += [
  :passw, :secret, :token, :crypt, :salt, :certificate, :otp, :ssn, :port, :host, :username, :database
]
