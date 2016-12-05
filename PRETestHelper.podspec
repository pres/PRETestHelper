Pod::Spec.new do |s|
  s.name         = "PRETestHelper"
  s.version      = "0.0.1"
  s.summary      = "Collection of Objective-C categories trying to simplify writing tests for iOS."
  s.homepage     = "https://github.com/pres/PRETestHelper"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "Paul Steinhilber" => "me@paulsteinhilber.de" }
  s.source       = { :git => "https://github.com/pres/PRETestHelper.git", :tag => s.version.to_s }
  s.source_files = 'PRETestHelper'
  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.dependency 'FBSnapshotTestCase'
end
