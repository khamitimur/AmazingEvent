# AmazingEvent

`AmazingEvent` is a generic and retention cycle free `Event` that enables instance of any type to notify multiple classes when something of interest occurs.

In other words, it's an attempt to bring C# like [`Event`](https://docs.microsoft.com/en-us/dotnet/standard/events/) to Swift and exploring what Swift version of [`Target-Action`](https://developer.apple.com/library/archive/documentation/General/Conceptual/Devpedia-CocoaApp/TargetAction.html) is like.

## Usage

The type that sends an `Event` is called the `publisher` and the classes that handle an `Event` are called `subscribers`.

#### Publisher
```swift
import AmazingEvent

class Car {
    // It's better to keep an event publisher private if you don't want it to be invoked by some other class.
    private var didStartPublisher = AmazingEventPublisher<Date>()
    
    // On initialization AmazingEventPublisher creates assosiated AmazingEvent.
    // Your job is to make this assosiated event reachable without exposing an event publisher itself.
    private(set) lazy var didStart = didStartPublisher.event
    
    // ...
    
    func start() {
        // Invokes the event by passing `self` as a sender.
        didStartPublisher.invoke(sender: self, parameter: Date())
    }
}
```

#### Subscriber
```swift
import AmazingEvent

class CarTestBench {
    init(car: Car) {
        car.didStart.subscribe(target: self, handleAction: CarTestBench.carDidStart)
    }
    
    private func carDidStart(sender: AnyObject?, parameter: Date) {
        // ...
    }
}
```

## Requirements

- macOS 10.14+
- iOS 11.0+
- tvOS 11.0+
- watchOS 4.0+
- Xcode 11+
- Swift 5.0+

## Installation

### CocoaPods

To integrate `AmazingEvent` into your Xcode project using [CocoaPods](https://cocoapods.org/), specify it in your `Podfile`:
```ruby
pod 'AmazingEvent', '~> 2.0'
```

### Swift Package Manager

To integrate `AmazingEvent` into your Xcode project using [Swift Package Manager](https://swift.org/package-manager/), specify it as dependency in your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/khamitimur/AmazingEvent.git", .upToNextMajor(from: "2.0.0"))
]
```

## License

This project is licensed under the [MIT License](LICENSE).

## Acknowledgments

* Inspired by [article](https://blog.scottlogic.com/2015/02/05/swift-events.html) by Colin Eberhardt.
