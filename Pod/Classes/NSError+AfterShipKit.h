//
//  NSError+AfterShipKit.h
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSError (AfterShipKit)

+ (NSError *)errorWithResponse:(NSDictionary *)response;
+ (NSError *)missingApiKey;

@end
