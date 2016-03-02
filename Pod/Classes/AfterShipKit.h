//
//  AfterShipKit.h
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import <Foundation/Foundation.h>

@class AFHTTPSessionManager;

@interface AfterShipKit : NSObject{
    AFHTTPSessionManager *manager;
    NSString *apiKey;
}

+ (AfterShipKit *)sharedInstance;

- (void)setAPIKey:(NSString *)key;

- (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                           fields:(NSArray<NSString *> *)fields
                          success:(void (^)(NSDictionary* dict))successBlock
                          failure:(void (^)(NSError* err))errorBlock;

@end
