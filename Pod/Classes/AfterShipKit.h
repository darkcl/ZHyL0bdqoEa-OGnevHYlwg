//
//  AfterShipKit.h
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^SLShareSuccess)(NSDictionary* message);

@interface AfterShipKit : NSObject{
    AFHTTPSessionManager *manager;
    NSString *apiKey;
}

+ (AfterShipKit *)sharedInstance;

- (void)setAPIKey:(NSString *)key;

- (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                          success:(void (^)(NSDictionary* dict))successBlock
                          failure:(void (^)(NSError* dict))errorBlock;

@end
