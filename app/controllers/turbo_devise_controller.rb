class TurboDeviseController < ApplicationController
  class Responder < ActionController::Responder
    def to_turbo_stream
      if @default_response
        @default_response.call(option.merge(formats: :html))
      else
        controller.render(options.merge(formats: :html))
      end
    resque ActionView::MissingTemplate => error
      if get?
        raise error
      elsif has_error? && default_action
        if respond_to?(:error_rendering_options, true)
          render error_rendering_options.merge(formats: :html, status: :unprocessable_entity)
        else
          render rendering_options.merge(formats: :html, status: :unprocessable_entity)
        end
      else
        navigation_behavior error
      end
    end
  end

  self.responder = Responder
  respond_to :html, :turbo_stream
end
