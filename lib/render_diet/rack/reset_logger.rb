module RenderDiet
  module Rack
    class ResetLogger

      def initialize(app)
        @app = app
      end

      def call(env)
        RenderDiet::Logger.reset
        @app.call(env)
      end

    end
  end
end

if defined?(Rails::Railtie)
  class RenderDiet::Railtie < Rails::Railtie
    initializer 'render_diet.insert_middleware' do |app|
      app.config.middleware.use RenderDiet::Rack::ResetLogger
    end
  end
else
  ActionController::Dispatcher.middleware.use(RenderDiet::Rack::ResetLogger)
end
