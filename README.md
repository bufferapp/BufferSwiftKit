**BufferSwiftKit** is a Swift based SDK to access the Buffer API. 
The main goal is to provide a simple and easy interface to use Buffer in your iOS apps.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org/)
[![Platforms](https://img.shields.io/badge/platform-ios%20%7C%20osx%20%7C%20watchos%7C%20tvos-lightgray.svg)]()
[![GitHub release](https://img.shields.io/badge/release-0.0.6-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-blue.svg)]()

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

1. Install BufferSwiftkit in your project
2. Create a Buffer developer account
3. Setup the client and start using the Kit

### 1. Install

#### Cocoapods
Add the following line into you ```Podfile```:

```
pod BufferSwiftKit
```

adn do a ```pod install```

#### Carthage

Add the following line to your ```Cartfile```:

```
github bufferapp/BufferSwiftKit
```

Run carthage 

```
carthage update BufferSwiftKit
```

Then just import the framework ```Carthage/Build``` depending on the platform of your app.

### 2. Buffer developer account

Go to https://buffer.com/developers/api and [create an app](https://buffer.com/developers/apps/create).

After completing the the process you receive the Client secret in your email. You'll need it configure OAuth 2.0.

The rest of the app information is located [here](https://buffer.com/developers/apps). Your application should loke similar to this:

![image](http://cl.ly/03453V0E1I07/ss.png)

### 3. Setup client

BufferKitClient just needs a token to interact with the API. So you could use the provided access token listed in the app's description for simple apps or use OAuth 2.0 to request for token associated with a particular user.

* Single token method: Is simpler and is preferred while prototyping you awesome app :)
* OAuth 2.0 token method: This is the recommended approach for production apps. Libraries like [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift) and [OAuth2](https://github.com/p2/OAuth2) are recommended for this method.

## Featutes

- [x] Callback based API support for iOS
- [x] Swift 2 support
- [x] OSX support
- [x] tvOS support
- [x] Carthage support
- [ ] Linux support
- [ ] RXSwift support

## Coding style

We adhere to the [Raywenderlich Swift codeing style](https://github.com/raywenderlich/swift-style-guide).

## ChangeLog

Please visit the [CHANGELOG.md](CHANGELOG.md) file.

## License

BufferSwiftKit is released under the MIT license. See [LICENSE](LICENSE) for details.
