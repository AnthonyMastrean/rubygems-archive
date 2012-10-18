require 'rake'
require 'installshield'

task :default => [ :msi ]

installshield :msi do |msi|
  msi.ism = 'd:/code/software/scanner/trunk/install/OmnyxScanner.ism'
  msi.parameters << "-l PATH_TO_RELEASE_FILES=\"d:\\code\\software\\scanner\\trunk\\bin\\Release\""
  msi.product_version = '0.0.5.0'
  msi.new_product_code!
end