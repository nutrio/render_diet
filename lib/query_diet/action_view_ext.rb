module QueryDiet
  module ActionViewExt
    def render(context, options)
=begin
       {:action=>"two_queries", :prefixes=>["query_diet", "application"], :template=>"two_queries", :layout=>#<Proc:0x007ff40c265928@/Users/ted/.rvm/gems/ruby-2.3.0/gems/actionview-5.0.0.beta2/lib/action_view/layouts.rb:386>}

       {:partial=>"nested", :template=>""}
=end
      QueryDiet::Logger.log(options[:partial] || options[:template]) { super }
    end
  end
end

ActionView::Renderer.send(:prepend, QueryDiet::ActionViewExt)
