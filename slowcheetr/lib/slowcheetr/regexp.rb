class Regexp
  def encode(encoding)
    Regexp.new self.to_s.encode encoding
  end
end
