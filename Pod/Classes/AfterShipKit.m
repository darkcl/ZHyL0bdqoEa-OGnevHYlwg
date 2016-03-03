//
//  AfterShipKit.m
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import "AfterShipKit.h"

#import "AfterShipTrackingInfo.h"
#import "AfterShipResponseSerializer.h"

#import <AFNetworking/AFNetworking.h>
#import "NSError+AfterShipKit.h"

@implementation AfterShipKit

+ (id)sharedInstance{
    static AfterShipKit *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (id)init{
    if (self = [super init]) {
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://api.aftership.com"]];
    }
    return self;
}

+ (void)setAPIKey:(NSString *)key{
    [[self sharedInstance] setAPIKey:key];
}

+ (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                           fields:(NSArray<NSString *> *)fields
                          success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                          failure:(void (^)(NSError* err))errorBlock{
    [[self sharedInstance] fetchTrackingInfoWithSlug:slug
                                         trackNumber:trackNumber
                                              fields:fields
                                             success:successBlock
                                             failure:errorBlock];
}

+ (void)createTrackingWithTrackingInfo:(AfterShipTrackingInfo *)trackingInfo
                               success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                               failure:(void (^)(NSError* err))errorBlock{
    [[self sharedInstance] createTrackingWithTrackingInfo:trackingInfo
                                                  success:successBlock
                                                  failure:errorBlock];
}

- (void)setAPIKey:(NSString *)key{
    apiKey = key;
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:apiKey forHTTPHeaderField:@"aftership-api-key"];
    [requestSerializer setValue:@"1.0.0" forHTTPHeaderField:@"aftership-ios-sdk"];
    requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer = requestSerializer;
}

+ (void)deleteTrackingWithTrackingNumber:(NSString *)trackingNumber
                                 andSlug:(NSString *)slug
                                 success:(void (^)(void))successBlock
                                 failure:(void (^)(NSError* err))errorBlock{
    [[self sharedInstance] deleteTrackingWithTrackingNumber:trackingNumber
                                                    andSlug:slug
                                                    success:successBlock
                                                    failure:errorBlock];
}

#pragma mark - Private Functions

- (void)deleteTrackingWithTrackingNumber:(NSString *)trackingNumber
                                 andSlug:(NSString *)slug
                                 success:(void (^)(void))successBlock
                                 failure:(void (^)(NSError* err))errorBlock{
    [manager DELETE:[NSString stringWithFormat:@"/v4/trackings/%@/%@", slug, trackingNumber]
         parameters:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                successBlock();
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                errorBlock(error);
            }];
}

- (void)createTrackingWithTrackingInfo:(AfterShipTrackingInfo *)trackingInfo
                               success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                               failure:(void (^)(NSError* err))errorBlock{
    AfterShipResponseSerializer *serializer = [AfterShipResponseSerializer serializer];
    [serializer setExpectedResponseClass:[AfterShipTrackingInfo class]
                                 isArray:NO];
    manager.responseSerializer = serializer;
    [manager POST:@"/v4/trackings"
       parameters:trackingInfo.dictionaryRepresentation
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
              successBlock(responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              errorBlock(error);
          }];
}

- (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                           fields:(NSArray<NSString *> *)fields
                          success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                          failure:(void (^)(NSError* err))errorBlock{
    AfterShipResponseSerializer *serializer = [AfterShipResponseSerializer serializer];
    [serializer setExpectedResponseClass:[AfterShipTrackingInfo class]
                                 isArray:NO];
    manager.responseSerializer = serializer;
    NSMutableDictionary *param;
    if (fields.count > 0) {
        param = [[NSMutableDictionary alloc] init];
        [param setObject:fields forKey:@"fields"];
    }
    
    if (apiKey == nil) {
        errorBlock([NSError missingApiKey]);
    }else if (slug.length == 0 || trackNumber.length == 0) {
        errorBlock([NSError missingParameters]);
    }else{
        [manager GET:[NSString stringWithFormat:@"/v4/trackings/%@/%@", slug, trackNumber]
          parameters:param
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 successBlock(responseObject);
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 errorBlock(error);
             }];
    }
}

@end
