
[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/EZSwiftExtensions.svg)](https://img.shields.io/cocoapods/v/LFAlertController.svg)  
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

# TestNABWeather

<p align="row">
<img src= "images/app-demo.gif" width="400" >
</p>

## Features

- [x] List Weather search by API
- [x] Search city by name
- [x] Setting font size
- [x] Setting celious to display
- [x] Setting number of day to search

## Software development princibles:

Follow by SOLID (define the protocol to init ViewController followed by MVVM structure)

## Structure:
- [x] Utils: Some common functions.
        +Configuration.swift: including some funtions to save and get local data
        +Constant.swift: Store some constant
- [x] Font: Folder of font source
- [x] Service: Networking service.
        +RequestBuilder.swift, SessionBuilder.swift: Store some protocol to define the full api resful service.
        +Networkingable: The typealias of request and responsed file
        +When calling 1 api, we will define in Operation folder and implement BaseOperation<GenericModelType>, inside each file we have the method, parameters and the response type.
- [x] Screens: ViewController followed by MVVM.
<img src= "https://www.google.com/url?sa=i&url=https%3A%2F%2Fbenoitpasquier.com%2Fios-swift-mvvm-pattern%2F&psig=AOvVaw0jKj95YK8816-_JvHEu-09&ust=1649911832654000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCJib8MKgkPcCFQAAAAAdAAAAABAI" width="400" >
        +When init of 1 viewController, the view has the reponsibiity to setup the view. All of the logic handlecd inside the viewModels class(private attributes), and the view has get the data from the viewModel to show off to the User.
- [x] Extensions: Some extensions of classes.
- [x] TestNABWeatherTest: The Test of ViewModel
- [x] TestNABWeatherUITestsZ: The Test of UI

## Libraries in Pods:
- [x] Kingfisher: Load uiimageview from online
- [x] MBProgressHUD: Show progress loading
- [x] Alamofire: Load restfull API
- [x] ESPullToRefresh: Pull to refresh of UITableView.
- [x] IQKeyboardManagerSwift: handle keyboard event

## How to run this project

-  Download this project from develop branch and run, to change some config, go to setting screen from setting button in the top of uinavigation bar.
-  To check Error handle, change value from 30 to 0.1 in SessionBuilder file a below:
        config.timeoutIntervalForRequest = 0.1
        config.timeoutIntervalForResource = 0.1
        
## Checklist
        
- [x] Programming language: Swift is required, Objective-C is optional.
- [x] Design app's architecture (recommend VIPER or MVP, MVVM but not mandatory)
- [x] UI should be looks like in attachment.
- [x] Write UnitTests
- [x] Acceptance Tests
- [x] Exception handling
- [x] Caching handling
- [x] Accessibility for Disability Supports:
    b. Scaling Text: Display size and font size: To change the size of items on your
screen, adjust the display size or font size.
- [x] Readme file includes:
    c. Brief explanation for the software development principles, patterns & practices
being applied
    d. Brief explanation for the code folder structure and the key Objective-C/Swift
libraries and frameworks being used
    e. All the required steps in order to get the application run on local computer
    f. Checklist of items the candidate has done.


## Requirements

- iOS 11.0+
- Xcode 13

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'YourLibrary'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import UIKit
import YourLibrary
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/YourLibrary.framework` to an iOS project.

```
github "yourUsername/yourlibrary"
```
#### Manually
1. Download and drop ```YourLibrary.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```

## Contribute

We would love you for the contribution to **YourLibraryName**, check the ``LICENSE`` file for more info.

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
