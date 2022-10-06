# frozen_string_literal: true

# Adapted from https://gist.github.com/westonganger/ef51c005c8a033436a1b8f074bf37463
module RoutesHandling
  extend ActiveSupport::Concern

  included do
    after_action :set_route_info

    def set_route_info
      session[:previous_url] = request.url
      session[:previous_controller] = prev_route[:controller]
      session[:previous_action] = prev_route[:action]
    end

    private

    def prev_route
      Rails.application.routes.recognize_path(URI(session[:previous_url]).path)
    end
  end
end
