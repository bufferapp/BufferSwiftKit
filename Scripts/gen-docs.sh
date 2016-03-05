cd BufferKitDemo
jazzy \
  --clean \
  --author Buffer \
  --author_url https://buffer.com \
  --github_url https://github.com/bufferapp/BufferSwiftKit \
  --github-file-prefix https://github.com/bufferapp/BufferSwiftKit/0.1.0 \
  --module-version 0.1.0 \
  --xcodebuild-arguments -scheme,BufferKitDemo \
  --module BufferKitDemo \
  --root-url http://localhost:8000/api/ \
  --output docs/swift_output 
  #--theme docs/themes
