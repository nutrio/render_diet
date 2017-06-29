module QueryDiet
  module ActionViewExt
    def render(context, options)
      QueryDiet::Logger.log(options[:partial] || options[:template]) { super }
    end
=begin
    def render_template(context, options)
      QueryDiet::Logger.log(options[:partial] || options[:template]) { super }
    end

    def render_partial(context, options, &block)
      QueryDiet::Logger.log(options[:partial] || options[:template]) { super }
    end
=end
  end
end

ActionView::Renderer.send(:prepend, QueryDiet::ActionViewExt)
