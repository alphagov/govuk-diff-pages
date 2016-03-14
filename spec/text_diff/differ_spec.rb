require_relative '../../lib/text_diff/differ'

RSpec.describe TextDiff::Differ do
  it 'returns the diff from given texts' do
    expect(described_class.new.diff("a\n", "b\n")).to eq("-a\n+b\n")
  end
end
