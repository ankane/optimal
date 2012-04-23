require "test_helper"

context "Array" do
  setup { [1, 2, 3, 4].distribution }

  asserts(:sum).equals 10
  asserts(:mean).equals 2.5
  asserts(:range).equals 3
  asserts(:median).equals 2.5
end

context "outliers" do
  outliers = [-10000, 10000]
  setup { ([0] * 100 + outliers).distribution }

  asserts(:outliers).equals outliers
end
