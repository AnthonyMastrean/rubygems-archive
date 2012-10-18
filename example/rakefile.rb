require 'rake'
require '../lib/installshield.rb'

task default => [ :msi ]

installshield :msi do |msi|
  msi.ism = './install/test.ism'
  msi.parameters << "-l PATH_TO_RELEASE_FILES=\"./bin\""
  msi.product_version = '0.0.5.0'
  msi.new_product_code!
end