module RenderDiet
  module Widget
    class << self

      def css
        <<-EOF
        <style type="text/css"><!--
          div#render_diet {
            position: absolute;
            top: 0;
            right: 0;
            background-color: black;
            color: white;
            z-index: 999;
            padding: 4px 6px;
            font: normal bold 12px/12px Arial, sans-serif;
            cursor: pointer;
          }
          div#render_diet.good {
            filter:alpha(opacity=30);
            -moz-opacity:0.3;
            -khtml-opacity: 0.3;
            opacity: 0.3;
          }
          div#render_diet.bad {
            background-color: red;
            font-size: 16px;
            line-height: 16px;
          }
        --></style>
        EOF
      end

      def html(options)
        #
        # since the render_diet_widget runs *inside* a view (generally "layout")
        # it will always be *at least* one off (if it's in the top-most render)
        #
        <<-EOF
        <div id="render_diet" class="#{RenderDiet::Logger.bad?(options) ? 'bad' : 'good' }" onclick="this.parentNode.removeChild(this);">
          #{RenderDiet::Logger.count} / #{RenderDiet::Logger.time}ms
        </div>
        EOF
      end

    end

    module Helper
      def render_diet_widget(options = {})
        html = Widget.css + Widget.html(options)
        html.respond_to?(:html_safe) ? html.html_safe : html
      end
    end

  end

end

ActionView::Base.send :include, RenderDiet::Widget::Helper
