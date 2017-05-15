Pod::Spec.new do |s|

  s.name         = "LYCopyLabel"
  s.version      = "1.1.0"
  s.summary      = "Sub Class of UILabel to make the label enable to be copyed when long pressed"

  s.homepage     = "https://github.com/liuyang20091130/LYCopyLabel"

  s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author       = { "liuyang20091130" => "liuyang20091130@163.com" }

  s.platform     = :ios
  s.platform     = :ios, "5.0"

  s.source       = { :git => "https://github.com/liuyang20091130/LYCopyLabel.git", :tag => "#{s.version}" }


  s.source_files  = "CopyLabel/LYCopyLabel/*.{h,m}"
  s.resource     = 'CopyLabel/LYCopyLabel.bundle'

  s.public_header_files = "CopyLabel/LYCopyLabel/*.h"

end
