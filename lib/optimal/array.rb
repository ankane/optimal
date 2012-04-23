class Array

  def distribution
    Optimal::Distribution.new(self)
  end

  def histogram(opts = {})
    Optimal::Histogram.new(self, opts)
  end

end
