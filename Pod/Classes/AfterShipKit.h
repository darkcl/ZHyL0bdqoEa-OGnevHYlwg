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

/**
 *  Singleton object for api manager
 *
 *  @return Singleton object for AfterShipKit
 */
+ (AfterShipKit *)sharedInstance;

/**
 *  Setting API Key for AfterShipKit
 *
 *  @param key API Key for AfterShipKit
 */
+ (void)setAPIKey:(NSString *)key;

/**
 *  Get tracking results of a single tracking.
 *
 *  @param slug         Unique code of courier. Get courier slug here ( https://www.aftership.com/docs/api/4/couriers )
 *  @param trackNumber  Tracking Number for tracking info
 *  @param fields       List of fields to include in the response. Use comma for multiple values. Fields to include: tracking_postal_code,tracking_ship_date,tracking_account_number,tracking_key,tracking_destination_country, title,order_id,tag,checkpoints,
 checkpoint_time, message, country_name
 Defaults: none, Example: title,order_id
 *  @param successBlock Passing result of AfterShipTrackingInfo
 *  @param errorBlock   Passing error for failure
 */
+ (void)fetchTrackingInfoWithSlug:(NSString *)slug
                      trackNumber:(NSString *)trackNumber
                           fields:(NSArray<NSString *> *)fields
                          success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                          failure:(void (^)(NSError* err))errorBlock;

/**
 *  Create a tracking.
 *
 *  @param trackingInfo AfterShipTrackingInfo object for create tracking ingo
 *  @param successBlock Passing result of AfterShipTrackingInfo
 *  @param errorBlock   Passing error for failure
 */
+ (void)createTrackingWithTrackingInfo:(AfterShipTrackingInfo *)trackingInfo
                               success:(void (^)(AfterShipTrackingInfo* trackingInfo))successBlock
                               failure:(void (^)(NSError* err))errorBlock;
/**
 *  Delete a tracking. (only for testing)
 *
 *  @param trackingNumber Tracking Number to delete
 *  @param slug           Tacking Slug id
 *  @param successBlock   Notify for success
 *  @param errorBlock     Passing error for failure
 */
+ (void)deleteTrackingWithTrackingNumber:(NSString *)trackingNumber
                                 andSlug:(NSString *)slug
                                 success:(void (^)(void))successBlock
                                 failure:(void (^)(NSError* err))errorBlock;

/**
 *  Getting current rate limit remaining
 *
 *  @return Current rate limit remain
 */
+ (NSInteger)rateLimitRemaining;

@end
