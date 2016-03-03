//
//  NSError+AfterShipKit.h
//  Pods
//
//  Created by Yeung Yiu Hung on 1/3/2016.
//
//

#import <Foundation/Foundation.h>

@interface NSError (AfterShipKit)

/**
 *  Parse response for error description
 *
 *  @param response Response NSDictionary from api
 *
 *  @return nil if no error, else return NSError description
 */
+ (NSError *)errorWithResponse:(NSDictionary *)response;

/**
 *  Missing Api key error
 *
 *  @return NSError description of missing api key
 */
+ (NSError *)missingApiKey;

/**
 *  Missing Parameter error
 *
 *  @return NSError description of missing parameter
 */
+ (NSError *)missingParameters;

/**
 *  Object Mapping Error
 *
 *  @return NSError description of object mapping error
 */
+ (NSError *)mappingError;

@end
