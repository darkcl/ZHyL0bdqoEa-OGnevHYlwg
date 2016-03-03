//
//  AfterShipResponseSerializer.h
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import <AFNetworking/AFNetworking.h>

/**
 *  AfterShipResponseSerializer is the response serializer for mapping API responses
 */
@interface AfterShipResponseSerializer : AFJSONResponseSerializer{
    Class responseClass;
    BOOL isNextResponseArray;
}

/**
 *  Set next expected class to map with
 *
 *  @param aClass  Class to map json result to model, must be AfterShipBaseObject subclass
 *  @param isArray Is Response an array
 */
- (void)setExpectedResponseClass:(Class)aClass
                         isArray:(BOOL)isArray;

@end
