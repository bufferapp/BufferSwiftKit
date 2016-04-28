Pod::Spec.new do |s|
    s.name              = "BufferSwiftKit"
    s.version           = "0.1.2"
    s.summary           = "BufferSwiftKit is a Swift based SDK to access the Buffer API."
    s.homepage          = "https://github.com/bufferapp/BufferSwiftKit.git"
    s.license           = { :type => "MIT", :file => "LICENSE" }
    s.author            = { "Humberto Aquino" => "humber@buffer.com", "Andrew Yates" => "andy@buffer.com", "Jordan Morgan" => "jordan@buffer.com" }
    s.source            = { :git => "https://github.com/bufferapp/BufferSwiftKit.git", :tag => s.version }
    s.social_media_url  = "https://twitter.com/bufferdevs"

    s.ios.deployment_target = "9.0"
    s.watchos.deployment_target = "2.0"
    s.tvos.deployment_target = "9.0"
    s.osx.deployment_target = "10.10"

    s.requires_arc      = true

    s.source_files      = "Sources/**/*.{h,swift}"

    s.dependency "Moya"
    s.dependency "ObjectMapper"

end
