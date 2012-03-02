
def it_raises_error(name, &block)
  it name do
    expect {
      self.instance_eval &block
    }.to raise_error
  end
end