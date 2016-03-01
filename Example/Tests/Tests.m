//
//  AfterShipKitTests.m
//  AfterShipKitTests
//
//  Created by Yeung Yiu Hung on 03/01/2016.
//  Copyright (c) 2016 Yeung Yiu Hung. All rights reserved.
//

// https://github.com/kiwi-bdd/Kiwi

#import <AfterShipKit/AfterShipKit.h>

SPEC_BEGIN(InitialTests)

describe(@"AfterShipKit tests", ^{
    context(@"Fetching service data", ^{
        
        it(@"should fail if api key is not set", ^{
            __block NSError *fetchedErr = nil;
            AfterShipKit *testManager = [[AfterShipKit alloc] init];
            
            [testManager fetchTrackingInfoWithSlug:@""
                                       trackNumber:@""
                                           success:^(NSDictionary *dict) {
                                               
                                           }
                                           failure:^(NSError *err) {
                                               fetchedErr = err;
                                           }];
            
            [[expectFutureValue(fetchedErr) shouldEventually] beNonNil];
        });
        
    });
});

SPEC_END

