
<img src="https://github.com/Jake-Prickett/plop-ios/blob/master/Documentation/Images/PLOP_Demo.gif?raw=true" width="270" align="right">

</br>

<p align="center">
<img src="https://raw.githubusercontent.com/Jake-Prickett/plop-ios/master/Documentation/Images/logo_image.png" width="400">

<H4 align="center">
<br>
Programmable Live Objects Panel
<br><a href="https://github.com/Jake-Prickett">Jake Prickett</a>
</H4>
</p>

<p align="center">
<br>
<a href="https://travis-ci.org/Jake-Prickett/plop-ios"><img alt="Build Status" src="https://travis-ci.org/Jake-Prickett/plop-ios.svg?branch=master"/></a>
<a href="https://codecov.io/gh/Jake-Prickett/plop-ios"><img alt="Code Coverage" src="https://codecov.io/gh/Jake-Prickett/plop-ios/branch/master/graph/badge.svg"/></a>
<a href="https://developer.apple.com/swift"><img alt="Swift 5" src="https://img.shields.io/badge/language-Swift_5-orange.svg"/></a>
<a href="https://cocoapods.org/pods/PLOP"><img alt="CocoaPods" src="https://img.shields.io/cocoapods/v/PLOP.svg"/></a>
<a href="https://github.com/Carthage/Carthage"><img alt="Carthage" src="https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)"/></a>
<a href="https://swift.org/package-manager"><img alt="Swift Package Manager" src="https://img.shields.io/badge/swift pm-compatible-yellow.svg"/></a>
<a href="https://cocoapods.org/pods/PLOP"><img alt="Platform" src="https://img.shields.io/cocoapods/p/PLOP.svg"/></a>
<a href="https://github.com/Jake-Prickett/plop-ios/blob/master/LICENSE"><img alt="LICENSE" src="https://img.shields.io/cocoapods/l/PLOP"></a>
<a href="https://cocoapods.org/pods/PLOP"><img alt="LICENSE" src="https://img.shields.io/github/release-date/Jake-Prickett/plop-ios"></a>
<a href="https://cocoapods.org/pods/PLOP"><img alt="LICENSE" src="https://img.shields.io/github/last-commit/Jake-Prickett/plop-ios?style=plastic"></a>
</p>
</br>

---

## Features 🎁

TODO

## Use Cases 📱

## Basic Usage
The Debug Panel is a hidden screen in an app that can be accessed via a defined entry point (Button only visible in `DEBUG` builds) or the shake gesture (CMD+CTRL+Z on Simulator).

Within the debug panel you can add functionality and hook up code that is not ready for production. 

> Note: The debug panel is only accessible when the DEBUG preprocessor flag is set to 1

---

Much of your setup can be done in your `AppDelegate.swift` you can have your setup code similar to below:

```swift
    import PLOP

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
	setupPLOPComponents() // Where you add sections, components, switches, etc.
	PLOP.enableShakeToLaunchPanel() // Enables Shake gesture presentation
	#endif
        return true
    }
```

Or, if you'd rather have the panel be presented on tap of a button:

```swift
   import PLOP
   
   class ViewController: UIViewController {

      override func viewDidLoad() {
          super.viewDidLoad()

          let button = UIButton(type: .system)
          button.setTitle("Show Panel", for: .normal)
          button.addTarget(self, action: #selector(togglePLOP), for: .touchUpInside)

          view.addSubview(button)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

          configurePLOP()
      }

      private func configurePLOP() {
          /*
    	     Where you add sections, components, switches, etc.
  	   */

          PLOP.reloadPanel()
      }

      @objc func togglePLOP() {
          PLOP.showPanel()
      }
   }  
```

> Note: Ensure that the button is only visible in `DEBUG` builds, otherwise you could have some issues where this could be visible in your `RELEASE` Scheme!!

## Frequently Asked Questions

Check out the [FAQ Page](https://github.com/Jake-Prickett/plop-ios/blob/master/Documentation/FAQ.md>)

## Installation 📦

Please reference the below instructions for installing PLOP.

## Requirements 📝
* iOS 11.0+
* Xcode 11.1+
* Swift 5.0+

### CocoaPods
PLOP is available through [CocoaPods](<https://cocoapods.org/>). To install it, simply add the following line to your `Podfile`:

	pod 'PLOP'

### Carthage

PLOP is available through [Carthage](<https://github.com/Carthage/Carthage>). To install it, simply add the following line to your Cartfile:

	github "Jake-Prickett/plop-ios"

### Swift Package Manager
PLOP is available through [Swift PM](<https://swift.org/package-manager/>). To install it, simply add the package as a dependency in `Package.swift`:

```swift
dependencies: [
  .package(url: "https://github.com/Jake-Prickett/plop-ios.git", from: "1.0.0"),
]
```

### Manual
Download and drop the `PLOP` directory into your project.

---

If you notice issues or have feature requests - please feel free to open an issue leveraging the corresponding template. 

**If you'd like to contribute - Please do!**
