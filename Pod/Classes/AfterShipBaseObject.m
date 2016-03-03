//
//  AfterShipBaseObject.m
//  Pods
//
//  Created by Yeung Yiu Hung on 3/3/16.
//
//

#import "AfterShipBaseObject.h"

@implementation AfterShipBaseObject

- (id)initWithInfo:(NSDictionary *)dict{
    NSAssert(NO, @"Your model class must implement modelWithDictionary: !");
    return nil;
}

- (void)dictionarySetValue:(id)value forKey:(NSString *)key toDictionary:(NSMutableDictionary *)dict{
    if (value != nil) {
        [dict setValue:value forKey:key];
    }
}

@end
