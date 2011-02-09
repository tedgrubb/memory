# Be sure to restart your server when you modify this file.

Memory::Application.config.session_store :cookie_store, :key => '_memory_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Memory::Application.config.session_store :active_record_store
