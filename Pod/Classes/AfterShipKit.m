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
        rateLimit = 600;
        rateLimitRemaining = 600;
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

+ (NSInteger)rateLimitRemaining{
    return [[self sharedInstance] rateLimitRemaining];
}

#pragma mark - Private Functions

- (void)deleteTrackingWithTrackingNumber:(NSString *)trackingNumber
                                 andSlug:(NSString *)slug
                                 success:(void (^)(void))successBlock
                                 failure:(void (^)(NSError* err))errorBlock{
    [manager DELETE:[NSString stringWithFormat:@"/v4/trackings/%@/%@", slug, trackingNumber]
         parameters:nil
            success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
                successBlock();
            }
            failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
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
              [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
              successBlock(responseObject);
          }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
              [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
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
                 [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
                 successBlock(responseObject);
             }
             failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self updateRateLimitFromRepsonse:(NSHTTPURLResponse*)task.response];
                 errorBlock(error);
             }];
    }
}

- (void)resetRateLimit{
    rateLimitRemaining = rateLimit;
}

- (NSInteger)rateLimitRemaining{
    return rateLimitRemaining;
}

- (void)updateRateLimitFromRepsonse:(NSHTTPURLResponse*)response{
    if ([response respondsToSelector:@selector(allHeaderFields)]) {
        NSDictionary *dictionary = [response allHeaderFields];
        /*
         x-ratelimit-limit
         x-ratelimit-remaining
         x-ratelimit-reset
         */
        rateLimitRemaining = [[dictionary objectForKey:@"x-ratelimit-remaining"] integerValue];
        rateLimit = [[dictionary objectForKey:@"x-ratelimit-limit"] integerValue];
        
        NSDate *resetRateLimitTime = [NSDate dateWithTimeIntervalSince1970:[[dictionary objectForKey:@"x-ratelimit-reset"] doubleValue]];
        
        if (resetTimer) {
            [resetTimer invalidate];
            resetTimer = nil;
        }
        
        NSTimeInterval secondsBetween = [resetRateLimitTime timeIntervalSinceDate:[NSDate date]];
        
        resetTimer = [NSTimer scheduledTimerWithTimeInterval:secondsBetween
                                                      target:self
                                                    selector:@selector(resetRateLimit)
                                                    userInfo:nil
                                                     repeats:NO];
    }
}

@end
