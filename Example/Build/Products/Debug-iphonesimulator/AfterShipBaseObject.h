//
//  AfterShipBaseObject.h
//  Pods
//
//  Created by Yeung Yiu Hung on 3/3/16.
//
//

#import <Foundation/Foundation.h>

/** Base Object for all AfterShip response model*/
@interface AfterShipBaseObject : NSObject

/**
 *  All subclass must have this function
 *
 *  @param dict Source for mapping values
 *
 *  @return object
 *
 *  @warning *Important:* Subclass without this will result in a runtime exception!
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
