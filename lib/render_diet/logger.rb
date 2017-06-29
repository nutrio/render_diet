module RenderDiet
  class Logger
    DEFAULT_OPTIONS = { :bad_count => 8, :bad_time => 5000 }

    class << self
      attr_accessor :renders, :paused

      def reset
        self.renders = []
      end

      def log(render)
        if paused?
          yield
        else
          result = nil
          time = Benchmark.realtime do
            result = yield
          end
          renders << [render, time] if log_render?(render)
          result
        end
      end

      def time
        (renders.sum(&:last) * 1000).to_i
      end

      def count
        renders.size
      end

      def bad?(options = {})
        options = options.reverse_merge(DEFAULT_OPTIONS)
        count >= options[:bad_count] or time >= options[:bad_time]
      end

      def paused?
        paused
      end

      private

      def log_render?(render)
        #render =~ /^(select|create|update|delete|insert)\b/i
        true # FIXME: only if not cached?
      end
    end

    reset
  end
end
