//
//  NSError+AfterShipKit.m
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import "NSError+AfterShipKit.h"

NSString * const kAferShipErrorDomain = @"com.aftership.error";

@implementation NSError (AfterShipKit)

+ (NSError *)errorWithResponse:(NSDictionary *)response{
    NSInteger responseCode = [response[@"meta"][@"code"] integerValue];
    if (responseCode == 200) {
        return nil;
    }else{
        return [NSError errorWithDomain:kAferShipErrorDomain
                                   code:responseCode
                               userInfo:@{NSLocalizedDescriptionKey : response[@"meta"][@"message"]}];
    }
}

+ (NSError *)missingApiKey{
    return [NSError errorWithDomain:kAferShipErrorDomain
                               code:0
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing Api key"}];
}

+ (NSError *)missingParameters{
    return [NSError errorWithDomain:kAferShipErrorDomain
                               code:1
                           userInfo:@{NSLocalizedDescriptionKey : @"Missing Parameters"}];
}

@end
