module Optimal
  class Histogram
    attr_reader :bins, :bin_count, :bin_width

    # k = number of bins
    def initialize(samples, opts = {})
      opts = symbolize_keys(opts)

      raise "No data." if samples.empty?

      min = samples.min
      max = samples.max
      @bin_count = optimal_bins(samples, opts[:bin_count] || :sturges)
      @bin_width = (max - min) / @bin_count.to_f

      raise "No variation." if @bin_width == 0

      @bins = {}
      @bin_count.times.each do |i|
        @bins[i] = {
          count: 0,
          min: min + @bin_width * i,
          max: min + @bin_width * (i + 1),
          midpoint: min + @bin_width * i + (@bin_width / 2)
        }
      end

      samples.each do |sample|
        bin = ((sample - min)/@bin_width).floor
        bin -= 1 if bin == @bin_count
        @bins[bin][:count] += 1
      end
    end

    def to_s(label = :min)
      label = label.to_sym
      label_width = @bins.values.last[label].to_i.to_s.size + 3
      count_max = @bins.values.map{|v| v[:count] }.max
      count_width = count_max.to_i.to_s.size
      bar_width = 80 - (label_width + count_width + 6)
      bar_ratio = bar_width / count_max.to_f

      @bins.map do |bin, values|
        "%#{label_width}.2f   %#{count_width}d   %s" % [values[label], values[:count], "#" * (bar_ratio*values[:count]).round]
      end.join("\n")
    end

    protected

    def optimal_bins(samples, opt)
      if opt.is_a?(Fixnum)
        opt
      else
        n = samples.size
        case opt.to_sym
        when :sturges
          Math.log(n, 2) + 1
        when :sqrt
          Math.sqrt(n)
        else
          raise "Unknown bin_count."
        end.ceil
      end
    end

    def symbolize_keys(obj)
      Hash[ obj.to_hash.map{|k, v| [k.to_sym, v] } ]
    end

  end
end
