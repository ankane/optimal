require "test_helper"

context "square root bin counts" do
  setup { [1, 2, 3, 4].histogram(:bin_count => :sqrt) }

  asserts(:bin_count).equals 2
end
