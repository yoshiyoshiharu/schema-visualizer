# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_from_auth_hash(auth_hash)
    User.find_by(email: user_params_from_auth_hash(auth_hash)[:email])
  end

  def self.user_params_from_auth_hash(auth_hash)
    {
      email: auth_hash.info.email
    }
  end

  private_class_method :user_params_from_auth_hash
end
