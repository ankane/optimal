module Optimal
  class Distribution

    def initialize(samples)
      raise "No samples." if samples.empty?
      @samples = samples.dup
      @size = samples.size
    end

    def sum
      @sum ||= @samples.inject { |sum, sample| sum += sample } || 0
    end

    def mean
     @mean ||= sum.to_f / @size
    end

    def median
      @median ||= median_helper(sorted_samples)
    end

    def variance
      @variance ||= @samples.inject(0.0){ |var, sample| var + (sample - mean) ** 2 } / (@size - 1)
    end

    def std_dev
      @std_dev ||= Math.sqrt(variance)
    end

    def q1
      @q1 ||= median_helper(sorted_samples.first(@size / 2))
    end

    def q3
      @q3 ||= median_helper(sorted_samples.last(@size / 2))
    end

    def percentile(percent)
      sorted_samples[(percent * @size).ceil - 1]
    end

    def midhinge
      @midhinge ||= (q1 + q3) / 2.0
    end

    def iqr
      @iqr ||= q3 - q1
    end

    def range
      @range ||= max - min
    end

    def min
      @min ||= @samples.min
    end

    def max
      @max ||= @samples.max
    end

    def sorted_samples
      @sorted_samples ||= @samples.sort
    end

    def outliers
      @outliers ||= begin
        iqr15 = 1.5 * iqr
        @samples.select{ |sample| (sample - median).abs > iqr15 }
      end
    end

    def to_s
      Hash[ [:mean, :median, :range, :iqr, :outliers].map{|meth| [meth, send(meth)] } ].inspect
    end

    protected

    def median_helper(sorted_samples)
      size = sorted_samples.size
      if size % 2 == 1
        sorted_samples[size / 2]
      else
        (sorted_samples[size / 2 - 1] + sorted_samples[size / 2]) / 2.0
      end
    end

  end
end
