//
//  AfterShipBaseObject.h
//  Pods
//
//  Created by Yeung Yiu Hung on 3/3/16.
//
//

#import <Foundation/Foundation.h>

@interface AfterShipBaseObject : NSObject

/**
 *  All subclass must have this function
 *
 *  @param dict
 *
 *  @return object
 */
- (id)initWithInfo:(NSDictionary *)dict;

/**
 *  Helper function for mapping dictionary
 *
 *  @param value Value for mapping
 *  @param key   Key for mapping
 *  @param dict  Target Dictionary for mapping
 */
- (void)dictionarySetValue:(id)value forKey:(NSString *)key toDictionary:(NSMutableDictionary *)dict;

@end
