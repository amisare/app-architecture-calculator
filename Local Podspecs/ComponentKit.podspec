Pod::Spec.new do |s|
  s.name = "ComponentKit"
  s.version = "0.29"
  s.summary = "A React-inspired view framework for iOS"
  s.homepage = "https://componentkit.org"
  s.authors = 'adamjernst@fb.com'
  s.license = 'BSD'
  s.source = {
    :path => "."
  }
  s.social_media_url = 'https://twitter.com/componentkit'
  s.platform = :ios, '7.0'
  s.requires_arc = true
  s.vendored_frameworks = 'Carthage/Build/iOS/ComponentKit.framework'
  s.frameworks = 'UIKit', 'CoreText'
  s.library = 'c++'
  s.xcconfig = {
    'CLANG_CXX_LANGUAGE_STANDARD' => 'c++14',
    'CLANG_CXX_LIBRARY' => 'libc++',
  }
end
