Clearance.configure do |config|
  config.routes = false
  config.mailer_sender = "y.tungmanelatkul@gmail.com"
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/users#index"
end
