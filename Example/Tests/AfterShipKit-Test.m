//
//  AfterShipKit-Test.m
//  AfterShipKit
//
//  Created by Yeung Yiu Hung on 2/3/16.
//  Copyright © 2016 Yeung Yiu Hung. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <AfterShipKit/AfterShipKit.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

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
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqualObjects(err.domain, @"com.aftership.error");
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
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqualObjects(err.domain, @"com.aftership.error");
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
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTAssertNotNil(trackingInfo);
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
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqualObjects(err.domain, @"com.aftership.error");
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
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertEqualObjects(err.domain, @"com.aftership.error");
                                       XCTAssertEqual(err.code, 4010);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}


- (void)testWrongResponseType {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing non json response"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://api.aftership.com/v4/trackings/dhl/1234567893"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = @"It's a stub!";
        return [OHHTTPStubsResponse responseWithData:[fixture dataUsingEncoding:NSUTF8StringEncoding]
                                          statusCode:200
                                             headers:@{@"Content-Type":@"text/plain"}];
    }];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [testManager fetchTrackingInfoWithSlug:@"dhl"
                               trackNumber:@"1234567893"
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTFail(@"Should not have response");
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       XCTAssertNotNil(err);
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
    
    [OHHTTPStubs removeAllStubs];
}

- (void)testMappingObject{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing non json response"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://api.aftership.com/v4/trackings/stub/me"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = [[NSBundle mainBundle] pathForResource:@"tracksample" ofType:@"json"];
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    [testManager setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDateFormatter *shipDateformatter = [[NSDateFormatter alloc] init];
    [shipDateformatter setDateFormat:@"yyyyMMdd"];
    
    [testManager fetchTrackingInfoWithSlug:@"stub"
                               trackNumber:@"me"
                                    fields:nil
                                   success:^(AfterShipTrackingInfo* trackingInfo) {
                                       XCTAssertNotNil(trackingInfo);
                                       
                                       XCTAssertEqualObjects(trackingInfo.trackingId, @"53c9f6fcc5cd69117f277276");
                                       XCTAssertEqualObjects(trackingInfo.createDate, [formatter dateFromString:@"2014-07-19T04:41:32+00:00"]);
                                       XCTAssertEqualObjects(trackingInfo.updateDate, [formatter dateFromString:@"2014-07-19T04:41:42+00:00"]);
                                       XCTAssertEqual(trackingInfo.trackingPostalCode, nil);
                                       XCTAssertEqual(trackingInfo.trackingShipDate, nil);
                                       XCTAssertEqual(trackingInfo.trackingAccountNumber, nil);
                                       XCTAssertEqual(trackingInfo.trackingKey, nil);
                                       XCTAssertEqual(trackingInfo.trackingDestinationCountry, nil);
                                       XCTAssertEqualObjects(trackingInfo.slug, @"ups");
                                       XCTAssertEqual(trackingInfo.isActive, NO);
                                       XCTAssertEqual(trackingInfo.androidDeviceToken, nil);
                                       XCTAssertEqualObjects(trackingInfo.customFields, @{});
                                       XCTAssertEqual(trackingInfo.customerName, nil);
                                       XCTAssertEqualObjects(trackingInfo.deliveryTime, @7);
                                       XCTAssertEqualObjects(trackingInfo.destinationCountryIso3, @"USA");
                                       XCTAssertEqualObjects(trackingInfo.emails, @[]);
                                       XCTAssertEqual(trackingInfo.expectedDelivery, nil);
                                       XCTAssertEqual(trackingInfo.iosDeviceIds, nil);
                                       XCTAssertEqual(trackingInfo.orderId, nil);
                                       XCTAssertEqual(trackingInfo.orderIdPath, nil);
                                       XCTAssertEqualObjects(trackingInfo.originCountryIso3, @"USA");
                                       XCTAssertEqualObjects(trackingInfo.uniqueToken, @"WJ9PLQt8e");
                                       XCTAssertEqualObjects(trackingInfo.shipmentType, @"GROUND");
                                       XCTAssertEqual(trackingInfo.shipmentWeight, @3.00);
                                       XCTAssertEqualObjects(trackingInfo.shipmentWeightUnit, @"LBS");
                                       XCTAssertEqualObjects(trackingInfo.signedBy, @"FRONT DOOR");
                                       XCTAssertEqualObjects(trackingInfo.smses, @[]);
                                       XCTAssertEqualObjects(trackingInfo.source, @"api");
                                       XCTAssertEqualObjects(trackingInfo.tag, @"Delivered");
                                       XCTAssertEqualObjects(trackingInfo.title, @"1Z45783E0398560742");
                                       XCTAssertEqualObjects(trackingInfo.trackedCount, @1);
                                       XCTAssertEqual(trackingInfo.checkpoints.count, 8);
                                       
                                       for (AfterShipCheckpointInfo *anInfo in trackingInfo.checkpoints) {
                                           XCTAssertTrue([anInfo isKindOfClass:[AfterShipCheckpointInfo class]]);
                                       }
                                       [expectation fulfill];
                                   }
                                   failure:^(NSError *err) {
                                       
                                       XCTFail(@"Should not have error");
                                       [expectation fulfill];
                                   }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
    
    [OHHTTPStubs removeAllStubs];
}

@end
