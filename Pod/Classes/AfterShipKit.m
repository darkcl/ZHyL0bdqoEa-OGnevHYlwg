//
//  AfterShipKit.m
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import "AfterShipKit.h"

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
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return self;
}

- (void)setAPIKey:(NSString *)key{
    apiKey = key;
    
    AFJSONRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:apiKey forHTTPHeaderField:@"aftership-api-key"];
    requestSerializer.HTTPShouldHandleCookies = NO;
    manager.requestSerializer = requestSerializer;
}

- (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                          success:(void (^)(NSDictionary* dict))successBlock
                          failure:(void (^)(NSError* dict))errorBlock{
    
    if (apiKey == nil) {
        errorBlock([NSError missingApiKey]);
    }else if (slug.length == 0 || trackNumber.length == 0) {
        errorBlock([NSError missingParameters]);
    }else{
        [manager GET:[NSString stringWithFormat:@"/v4/trackings/%@/%@", slug, trackNumber]
          parameters:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                 successBlock(responseObject);
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 NSData *errorResponseData= error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey];
                 if (errorResponseData != nil) {
                     NSError *jsonError;
                     NSDictionary *errorResponseDict = [NSJSONSerialization JSONObjectWithData:errorResponseData
                                                                                       options:NSJSONReadingAllowFragments
                                                                                         error:&jsonError];
                     if (jsonError == nil) {
                         errorBlock([NSError errorWithResponse:errorResponseDict]);
                     }else{
                         errorBlock(error);
                     }
                     
                 }else{
                     errorBlock(error);
                 }
             }];
    }
}

@end
