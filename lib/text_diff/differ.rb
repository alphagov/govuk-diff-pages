require 'diffy'

module TextDiff
  class Differ
    def diff(left, right)
      Diffy::Diff.new(left, right).to_s
    end
  end
end
