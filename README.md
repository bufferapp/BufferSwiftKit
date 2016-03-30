**BufferSwiftKit** is a Swift based SDK to access the Buffer API. 
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

### 1. Cocoapods

Add the following line into you Podfile:

```
pod BufferSwiftKit
```

adn do a ```pod install```

### 2. Buffer developer account

Go to https://buffer.com/developers/api and [create an app](https://buffer.com/developers/apps/create).

After completing the the process you receive the Client secret in your email. You'll need it configure OAuth 2.0.

The rest of the app information is located [here](https://buffer.com/developers/apps). Your application should loke similar to this:

![image](http://cl.ly/03453V0E1I07/ss.png)

### 3. Setup client

BufferKitClient just needs a token to interact with the API. So you could use the provided access token listed in the app's description for simple apps or use OAuth 2.0 to request for token associated with a particular user.

* Single token method: Is simpler and is preferred while prototyping you awesome app :)
* OAuth 2.0 token method: This is the recommended approach for your production app. To see an example of how to do it please check the Sample project section bellow.

## Sample project

This projects uses cocapods-keys to store secrets. It you don't have it installed yet please do it bu running:
```
gem update cocoapods-keys
```

Obs.: If you don't use RVM then please run the above command with ```sudo```.

After that just run:
```
pod install
```

And fill the secrets when they are asked.

At this point you should be able to build and run the sample project. Check ```AuthManager.swift``` for implementation details/

## Featutes

- [x] Callback based API support for iOS
- [x] Swift 2 support
- [ ] RXSwift support
- [ ] Tested on OSX 
- [ ] tvOS support
- [ ] Tested on Linux
- [ ] Carthage support


## Coding style

We adhere to the [Raywenderlich Swift codeing style](https://github.com/raywenderlich/swift-style-guide).

## ChangeLog

Please visit the [CHANGELOG.md](CHANGELOG.md) file.

## License

BufferSwiftKit is released under the MIT license. See [LICENSE](LICENSE) for details.
