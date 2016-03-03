//
//  AfterShipBaseObject.h
//  Pods
//
//  Created by Yeung Yiu Hung on 3/3/16.
//
//

#import <Foundation/Foundation.h>

@interface AfterShipBaseObject : NSObject

- (id)initWithInfo:(NSDictionary *)dict;
- (void)dictionarySetValue:(id)value forKey:(NSString *)key toDictionary:(NSMutableDictionary *)dict;

@end
