module RenderDiet
  module ActionViewExt
    def render(context, options)
      RenderDiet::Logger.log(options[:partial] || options[:template]) { super }
    end
=begin
    def render_template(context, options)
      RenderDiet::Logger.log(options[:partial] || options[:template]) { super }
    end

    def render_partial(context, options, &block)
      RenderDiet::Logger.log(options[:partial] || options[:template]) { super }
    end
=end
  end
end

ActionView::Renderer.send(:prepend, RenderDiet::ActionViewExt)
