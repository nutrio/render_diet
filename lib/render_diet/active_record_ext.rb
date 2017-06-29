module RenderDiet
  module ActiveRecordExt
    def log(render, *)
      RenderDiet::Logger.log(render) { super }
    end
  end
end

ActiveRecord::ConnectionAdapters::AbstractAdapter.send(:prepend, RenderDiet::ActiveRecordExt)
