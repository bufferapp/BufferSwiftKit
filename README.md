![image](http://cl.ly/0U2E212I0a1E/logo.png)
 
BufferSwiftKit is a Swift based SDK to access the Buffer API. 
The main goal is to provide a simple and easy interface to use Buffer in your iOS apps.

## Sample code

```swift

// Can get the token from https://buffer.com/developers/api
// Or use OAuth 2.0. See the demo project for a sample

let token = "...." 

self.bufferClient = MoyaBufferClient(token: token)

client.getProfiles({ (profiles) -> Void in
    print("All right! You have \(profiles.count) profiles!")
}, failure: { (error) -> Void in
    print(error)
})

```

## Project status

This project is actively under development.
Currently, we support Xcode 7 and Swift 2.

## How to get started

1. Install Bufferkit pod in your project
2. Create a Buffer developer account
3. Setup the client and start using the Kit

### Cocoapods

Add the following line into you Podfile

```
pod BufferSwiftKit
```

### Buffer developer account

Go to https://buffer.com/developers/api and [create an app](https://buffer.com/developers/apps/create).

When you complete the process you will have a 

### Setup client

Inside your project configure the client 

You can use the token directly or use OAuth2.0. For this method please check the Sample project

## Sample project

TODO: Explain about the oauth keys and where to change them (cocapods-keys).

## Featutes

- [x] Callback based API support for iOS
- [x] Swift 2 support
- [ ] RXSwift support
- [ ] Tested on OSX 
- [ ] tvOS support
- [ ] Tested on Linux
- [ ] Carthage support


## Coding styel

We adhere to the [Raywenderlich Swift codeing style](https://github.com/raywenderlich/swift-style-guide).

## ChangeLog

Please visit the [CHANGELOG.md](CHANGELOG.md) file.

## License

BufferSwiftKit is released under the MIT license. See [LICENSE](LICENSE) for details.
