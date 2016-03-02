//
//  AfterShipResponseSerializer.h
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import <AFNetworking/AFNetworking.h>

@interface AfterShipResponseSerializer : AFJSONResponseSerializer{
    Class responseClass;
    BOOL isNextResponseArray;
}

- (void)setExpectedResponseClass:(Class)aClass
                         isArray:(BOOL)isArray;

@end
