# CommonUIKitComponents

[![CI Status](https://img.shields.io/travis/luisMan97/CommonUIKitComponents.svg?style=flat)](https://travis-ci.org/luisMan97/CommonUIKitComponents)
[![Version](https://img.shields.io/cocoapods/v/CommonUIKitComponents.svg?style=flat)](https://cocoapods.org/pods/CommonUIKitComponents)
[![License](https://img.shields.io/cocoapods/l/CommonUIKitComponents.svg?style=flat)](https://cocoapods.org/pods/CommonUIKitComponents)
[![Platform](https://img.shields.io/cocoapods/p/CommonUIKitComponents.svg?style=flat)](https://cocoapods.org/pods/CommonUIKitComponents)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 12.0+

## Installation

### CocoaPods

CommonUIKitComponents is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CommonUIKitComponents'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler. 

Once you have your Swift package set up, adding Alamofire as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/luisMan97/CommonUIKitComponents.git", .upToNextMajor(from: "1.1.0"))
]
```

___
## Componentes
___

#### **1. ModalViewController**

![Alt text](/Resources/ModalViewController/modalViewController.gif "ModalViewController")

**Compatibilidad:** Swift

**_v1.0.0:_**: 

- **Métodos:**

```swift

//Present an ModalViewController
func showModal
```

- **Usage examples:**

```swift
let alertView = AlertView().then {
    if #available(iOS 13.0, *) { $0.alertImage = UIImage(systemName: "pencil.circle.fill") }
    $0.titleText = "Title"
    $0.messageText = "Description"
    $0.titleTextColor = .blue
}

let modalConfiguration = ModalConfiguration()
    .setCustomView(alertView)
    
showModal(modalConfiguration, primaryCompletion: {
    print("Primary button tapped")
})
```

## Author

luisMan97, riveraladinojorgeluis@gmail.com

## License

CommonUIKitComponents is available under the MIT license. See the LICENSE file for more info.
