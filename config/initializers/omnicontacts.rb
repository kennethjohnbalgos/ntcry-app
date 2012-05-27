require "omnicontacts"

Rails.application.middleware.use OmniContacts::Builder do
  importer :gmail, 
    "client_id",
    "client_secret", 
    {:redirect_path => "/oauth2callback", :ssl_ca_file => "/etc/ssl/certs/curl-ca-bundle.crt"}
  importer :yahoo, 
    "dj0yJmk9YzJyVEJ2WWJqVnhFJmQ9WVdrOVoydG1hRUptTnpBbWNHbzlNVEk1TlRNMk5qazJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD1mMA--", 
    "c3c4ad335b041eeb5b48e5c897c3c4a362bf7c9b", 
    {:callback_path => '/callback'}
  importer :hotmail, "client_id", "client_secret"
end