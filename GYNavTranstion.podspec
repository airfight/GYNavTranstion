Pod::Spec.new do |s|

  s.name         = "GYNavTranstion"
  s.version      = "0.0.1"
  s.summary      = "导航侧滑"
  s.homepage     = "https://github.com/airfight/GYNavTranstion"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "airfight" => "745756619@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => 'https://github.com/airfight/GYNavTranstion.git', :tag => s.version }
  s.source_files = "GYNavigationBarTranstion/GYNavBar/*.swift"
  s.requires_arc = true

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.0' }
  
end

