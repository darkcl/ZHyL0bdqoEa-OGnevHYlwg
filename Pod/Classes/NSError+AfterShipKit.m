//
//  NSError+AfterShipKit.m
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import "NSError+AfterShipKit.h"

NSString * const kAferShipErrorDomain = @"com.afertship.error";

@implementation NSError (AfterShipKit)

+ (NSError *)errorWithResponse:(NSDictionary *)response{
    return nil;
}

+ (NSError *)missingApiKey{
    return [NSError errorWithDomain:kAferShipErrorDomain
                               code:0
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing Api key"}];
}

@end
