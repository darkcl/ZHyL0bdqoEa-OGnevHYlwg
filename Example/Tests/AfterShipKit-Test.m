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

@interface AfterShipKit_Test : XCTestCase

@end

@implementation AfterShipKit_Test

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [AfterShipKit setAPIKey:nil];
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    [AfterShipKit setAPIKey:nil];
}

- (void)testEmptyAPIKey {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Empty API Key"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@""
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
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@""
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
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"dhl"
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

- (void)testFields {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Fulfill all parameter"];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"dhl"
                                trackNumber:@"1234567883"
                                     fields:@[@"title"]
                                    success:^(AfterShipTrackingInfo* trackingInfo) {
                                        XCTAssertNotNil(trackingInfo);
                                        XCTAssertEqualObjects(trackingInfo.title, @"Title Name");
                                        XCTAssertNil(trackingInfo.trackingId);
                                        XCTAssertNil(trackingInfo.createDate);
                                        XCTAssertNil(trackingInfo.updateDate);
                                        XCTAssertNil(trackingInfo.trackingNumber);
                                        XCTAssertNil(trackingInfo.trackingAccountNumber);
                                        XCTAssertNil(trackingInfo.trackingPostalCode);
                                        XCTAssertNil(trackingInfo.trackingShipDate);
                                        XCTAssertNil(trackingInfo.trackingKey);
                                        XCTAssertNil(trackingInfo.trackingDestinationCountry);
                                        XCTAssertNil(trackingInfo.slug);
                                        XCTAssertNil(trackingInfo.androidDeviceToken);
                                        XCTAssertNil(trackingInfo.customFields);
                                        XCTAssertNil(trackingInfo.customerName);
                                        XCTAssertNil(trackingInfo.deliveryTime);
                                        XCTAssertNil(trackingInfo.destinationCountryIso3);
                                        XCTAssertNil(trackingInfo.emails);
                                        XCTAssertNil(trackingInfo.expectedDelivery);
                                        XCTAssertNil(trackingInfo.iosDeviceIds);
                                        XCTAssertNil(trackingInfo.orderId);
                                        XCTAssertNil(trackingInfo.orderIdPath);
                                        XCTAssertNil(trackingInfo.originCountryIso3);
                                        XCTAssertNil(trackingInfo.uniqueToken);
                                        XCTAssertNil(trackingInfo.shipmentPackageCount);
                                        XCTAssertNil(trackingInfo.shipmentType);
                                        XCTAssertNil(trackingInfo.shipmentWeightUnit);
                                        XCTAssertNil(trackingInfo.signedBy);
                                        XCTAssertNil(trackingInfo.smses);
                                        XCTAssertNil(trackingInfo.source);
                                        XCTAssertNil(trackingInfo.tag);
                                        XCTAssertNil(trackingInfo.trackedCount);
                                        XCTAssertNil(trackingInfo.checkpoints);
                                        
                                        [expectation fulfill];
                                    }
                                    failure:^(NSError *err) {
                                        XCTFail(@"Should not failed, %@", err);
                                        [expectation fulfill];
                                    }];
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testWrongTrackingNumber {
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing wrong track number"];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"dhl"
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
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"dhl-is-awesome"
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
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"dhl"
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
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing mapping json response"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://api.aftership.com/v4/trackings/stub/me"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = [[NSBundle mainBundle] pathForResource:@"tracksample" ofType:@"json"];
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200 headers:@{@"Content-Type":@"application/json"}];
    }];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDateFormatter *shipDateformatter = [[NSDateFormatter alloc] init];
    [shipDateformatter setDateFormat:@"yyyyMMdd"];
    
    [AfterShipKit fetchTrackingInfoWithSlug:@"stub"
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
                                        XCTAssertEqualObjects(trackingInfo.shipmentWeight, @3.00);
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
                                            XCTAssertEqualObjects(anInfo.slug, @"ups");
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

- (void)testTrackingInfoDictionaryRepresentation{
    NSString* sampleJsonPath = [[NSBundle mainBundle] pathForResource:@"tracking_post_sample" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:sampleJsonPath];
    NSError *jsonError;
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingAllowFragments
                                                               error:&jsonError];
    XCTAssertNil(jsonError, "Should Read json");
    
    AfterShipTrackingInfo *anInfo = [[AfterShipTrackingInfo alloc] initWithTrackingNumber:@"123456789"];
    anInfo.slug = @"dhl";
    anInfo.title = @"Title Name";
    anInfo.smses = @[@"+18555072509", @"+18555072501"];
    anInfo.emails = @[@"email@yourdomain.com", @"another_email@yourdomain.com"];
    anInfo.orderId = @"ID 1234";
    anInfo.orderIdPath = @"http://www.aftership.com/order_id=1234";
    anInfo.customFields = @{@"product_name": @"iPhone Case",
                            @"product_price": @"USD19.99"};
    
    XCTAssertEqualObjects(jsonDict, anInfo.dictionaryRepresentation);
}

- (void)testEmptyTrackNumber{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Empty Track Number"];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    AfterShipTrackingInfo *anInfo = [[AfterShipTrackingInfo alloc] initWithTrackingNumber:@""];
    [AfterShipKit createTrackingWithTrackingInfo:anInfo
                                         success:^(AfterShipTrackingInfo *trackingInfo) {
                                             XCTFail(@"Should not have response");
                                             [expectation fulfill];
                                         }
                                         failure:^(NSError *err) {
                                             XCTAssertNotNil(err);
                                             XCTAssertEqualObjects(err.domain, @"com.aftership.error");
                                             [expectation fulfill];
                                         }];
    
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testCreateTrackingInfo{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Create Tracking Info"];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    [AfterShipKit deleteTrackingWithTrackingNumber:@"1234567880"
                                           andSlug:@"dhl"
                                           success:^{
                                               AfterShipTrackingInfo *anInfo = [[AfterShipTrackingInfo alloc] initWithTrackingNumber:@"1234567880"];
                                               anInfo.slug = @"dhl";
                                               anInfo.title = @"Title Name";
                                               anInfo.smses = @[@"+18555072509", @"+18555072501"];
                                               anInfo.emails = @[@"email@yourdomain.com", @"another_email@yourdomain.com"];
                                               anInfo.orderId = @"ID 1234";
                                               anInfo.orderIdPath = @"http://www.aftership.com/order_id=1234";
                                               anInfo.customFields = @{@"product_name": @"iPhone Case",
                                                                       @"product_price": @"USD19.99"};
                                               
                                               [AfterShipKit createTrackingWithTrackingInfo:anInfo
                                                                                    success:^(AfterShipTrackingInfo *trackingInfo) {
                                                                                        XCTAssertNotNil(trackingInfo);
                                                                                        
                                                                                        [expectation fulfill];
                                                                                    }
                                                                                    failure:^(NSError *err) {
                                                                                        XCTFail(@"Should not have error");
                                                                                        [expectation fulfill];
                                                                                    }];
                                           }
                                           failure:^(NSError *err) {
                                               XCTFail(@"Should not have error");
                                               [expectation fulfill];
                                           }];
    
    
    
    [self waitForExpectationsWithTimeout:30.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertNil(error);
                                 }];
}

- (void)testRateLimit{
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing Rate Limit"];
    
    [AfterShipKit setAPIKey:@"a71a336b-aaff-43f9-b98d-e19aa83cd93b"];
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return [request.URL.absoluteString isEqualToString:@"https://api.aftership.com/v4/trackings/stub/me"];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        NSString* fixture = [[NSBundle mainBundle] pathForResource:@"tracksample" ofType:@"json"];
        NSDate *resetDate = [NSDate dateWithTimeIntervalSinceNow:5];
        
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:200
                                                   headers:@{@"Content-Type":@"application/json",
                                                             @"x-ratelimit-limit": @"610",
                                                             @"x-ratelimit-remaining": @"450",
                                                             @"x-ratelimit-reset": [[NSNumber numberWithDouble:[resetDate timeIntervalSince1970]] stringValue]}];
    }];
    [AfterShipKit fetchTrackingInfoWithSlug:@"stub"
                                trackNumber:@"me"
                                     fields:nil
                                    success:^(AfterShipTrackingInfo* trackingInfo) {
                                        XCTAssertTrue([AfterShipKit rateLimitRemaining] == 450);
                                    }
                                    failure:^(NSError *err) {
                                        XCTAssertTrue([AfterShipKit rateLimitRemaining] == 450);
                                    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [expectation fulfill];
    });
    
    [self waitForExpectationsWithTimeout:12.0
                                 handler:^(NSError * _Nullable error) {
                                     XCTAssertTrue([AfterShipKit rateLimitRemaining] == 610, @"Expected 610, Result : %i",(int)[AfterShipKit rateLimitRemaining]);
                                     XCTAssertNil(error);
                                 }];
    
    [OHHTTPStubs removeAllStubs];
}

@end
