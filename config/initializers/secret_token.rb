require 'foreman/util'
include Foreman::Util

unless Foreman::Application.config.secret_token
  token_store = Rails.root.join("tmp", "secret_token")
  token = File.read(token_store) if File.exist? token_store
  unless token
    token = secure_token
    File.open(token_store, "w", 0600) { |f| f.write(token) }
  end
  Foreman::Application.config.secret_token = token
end
