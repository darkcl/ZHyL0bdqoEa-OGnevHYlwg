//
//  AfterShipKit.h
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import <Foundation/Foundation.h>

#import "AfterShipTrackingInfo.h"

@class AFHTTPSessionManager;

@interface AfterShipKit : NSObject{
    AFHTTPSessionManager *manager;
    NSString *apiKey;
    
    NSInteger rateLimit;
    NSTimer *resetTimer;
    NSInteger rateLimitRemaining;
}

+ (AfterShipKit *)sharedInstance;

+ (void)setAPIKey:(NSString *)key;

+ (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                           fields:(NSArray<NSString *> *)fields
                          success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                          failure:(void (^)(NSError* err))errorBlock;

+ (void)createTrackingWithTrackingInfo:(AfterShipTrackingInfo *)trackingInfo
                               success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                               failure:(void (^)(NSError* err))errorBlock;

+ (void)deleteTrackingWithTrackingNumber:(NSString *)trackingNumber
                                 andSlug:(NSString *)slug
                                 success:(void (^)(void))successBlock
                                 failure:(void (^)(NSError* err))errorBlock;

+ (NSInteger)rateLimitRemaining;

@end
