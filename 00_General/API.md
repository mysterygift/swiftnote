# Application Programming Interfaces (APIs)

APIs are generally used in two ways in app development:

1. Making networking calls.
* Clients request information from servers, and the API is what handles these requests and sends information. An API can sometimes be open, sometimes they are closed and sometimes they are free (often limited by the number of requests in a timeframe)/paid.

2. Apple/Platform-specific APIs (e.g. how we interact with Apple's own APIs to make use of the foundations of their OS).
* We interact with Apple's foundation via an API. (e.g. view.backgroundColour = .green) – Apple's API then handles drawing the pixels on the screen.
* Frameworks provided by Apple all have their own APIs (e.g. CoreLocation, MapKit, ARKit).

# Checking API Availability

Swift reports errors at compile time if APIs are unavailable. You can use an availability condition in guard/if statements to check if APIs are available at runtime. See below.

```swift
if #available(iOS 10, macOS 10.13, *) {
    // Use iOS 10/macOS 10.13 APIs. The * is essential and specificies that on other platforms the code in the if statement executes on the "minimum deployment target" specified by the target.
} else {
    // Fall back to earlier APIs.
}
```

A minimum deployment target specifies the oldest OS version an app is designed to run on. It determines which APIs can run unconditionally in a codebase, potential userbase (lower deployment targets reach more users but limit features).

Here's an example of how availability guards can refine the avaiability info that's used for a code block:

```swift
@available(macOS 10.12, *) // The @available attribute means this applies to this struct.
struct FavouriteColour {
    var bestcolour = "Red"
}

func chooseBestColour() -> String {
    guard #available(macOS 10.2, *) else { // if on macOS 10.2 or above, proceed to let colours = ... otherwise return grey.
        return "grey"
    }
    let colours = FavouriteColour()
    return colours.bestcolour
}
```

The availability guard above allows the code to fall back to behaviour that's available to older versions of an OS if needed.

You can also check for the opposite in these two ways:

```swift
if #available(iOS 15, *) {
} else {
    // Fallback
}

if #unavailable(iOS 15) {
    // Fallback as well, although this second option is more readable.
}
```