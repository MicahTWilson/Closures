# Closures

Closures is an extension that lets you handle button actions and view gestures similar to a way you would handle a `clickListener` in Android.

You use it by simply calling:
```swift
let button = UIButton()
button.actionHandle(controlEvents: .touchUpInside, identifier: nil) {
    print("Button Tapped!")
}
```
    
    
or for a `UIGestureRecognizer`

```swift
let view = UIView()
view.addGesture(gestureType: .tap, identifier: nil) {
    print("View Tapped!")
}
```
