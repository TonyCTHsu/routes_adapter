module InputStringHelper
  def self.format(string)
    string.tr('\"', '').gsub(', ', ',')
  end
end
