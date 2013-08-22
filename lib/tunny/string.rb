class String
  def quote
    "\"#{self}\""
  end
  
  def windows_path
    gsub "/", "\\"
  end
  
  def posix_path
    gsub "\\", "/"
  end
end
