//
//  AfterShipKit-Test.m
//  AfterShipKit
//
//  Created by Yeung Yiu Hung on 2/3/16.
//  Copyright © 2016 Yeung Yiu Hung. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AfterShipKit/AfterShipKit.h>
#import <Nocilla/Nocilla.h>

@interface AfterShipKit_Test : XCTestCase{
    AfterShipKit *testManager;
}

@end

@implementation AfterShipKit_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    testManager = [[AfterShipKit alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    testManager = nil;
}

- (void)testEmptyAPIKey {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Empty API Key"];
    
    [testManager fetchTrackingInfoWithSlug:@""
                               trackNumber:@""
                                   success:^(NSDictionary *dict) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqual(err.domain, @"com.aftership.error");
                                       XCTAssertEqual(err.code, 0);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testEmptyParameters {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Empty Parameter"];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [testManager fetchTrackingInfoWithSlug:@""
                               trackNumber:@""
                                   success:^(NSDictionary *dict) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqual(err.domain, @"com.aftership.error");
                                       XCTAssertEqual(err.code, 1);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testFulfillAll {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Fulfill all parameter"];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [testManager fetchTrackingInfoWithSlug:@"dhl"
                               trackNumber:@"1234567893"
                                   success:^(NSDictionary *dict) {
                                       XCTAssertNotNil(dict);
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTFail(@"%@", err);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testWrongTrackingNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing wrong track number"];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [testManager fetchTrackingInfoWithSlug:@"dhl"
                               trackNumber:@"12345678931234"
                                   success:^(NSDictionary *dict) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqual(err.domain, @"com.aftership.error");
                                       XCTAssertEqual(err.code, 4004);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testWrongSlugName {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing wrong slug name"];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [testManager fetchTrackingInfoWithSlug:@"dhl-is-awesome"
                               trackNumber:@"1234567893"
                                   success:^(NSDictionary *dict) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqual(err.domain, @"com.aftership.error");
                                       XCTAssertEqual(err.code, 4010);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}


@end
