# AfterShipKit

[![Build Status](https://travis-ci.org/darkcl/ZHyL0bdqoEa-OGnevHYlwg.svg?branch=master)](https://travis-ci.org/darkcl/ZHyL0bdqoEa-OGnevHYlwg)

## Usage

Before you started with using our AfterShipKit, you will need to obtain your API key under your own user account.

* Login to your AfterShip account ([Sign up free](https://www.aftership.com/signup))
* Visit [Apps > API](https://www.aftership.com/apps/api) and click `add`
* Click `Generate API Key`

Setting up AfterShipKit with your api key:

```objc
[AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
```

Then use it!

```objc
[AfterShipKit fetchTrackingInfoWithSlug:@"dhl"
                                trackNumber:@"1234567893"
                                     fields:nil
                                    success:^(AfterShipTrackingInfo* trackingInfo) {
                                        //Handle Result 
                                    }
                                    failure:^(NSError *err) {
                                        //Handle Error
                                    }];
```

For more information, view [Documentation](http://darkcl.github.io/ZHyL0bdqoEa-OGnevHYlwg/)

## Requirements
XCode 7.0+

## Installation

AfterShipKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "AfterShipKit"
```

## Author

Yeung Yiu Hung, hkclex@gmail.com

## License

AfterShipKit is available under the MIT license. See the LICENSE file for more info.
