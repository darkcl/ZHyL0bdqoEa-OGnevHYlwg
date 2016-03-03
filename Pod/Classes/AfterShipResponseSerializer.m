//
//  AfterShipResponseSerializer.m
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import "AfterShipResponseSerializer.h"
#import "NSError+AfterShipKit.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

#import "AfterShipTrackingInfo.h"

@implementation AfterShipResponseSerializer

- (void)setExpectedResponseClass:(Class)aClass
                         isArray:(BOOL)isArray{
    responseClass = aClass;
    isNextResponseArray = isArray;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSError *responseError;
    id responseObject = [super responseObjectForResponse:response
                                                    data:data
                                                   error:&responseError];
    if (responseError) {
        if (data != nil) {
            NSError *jsonError;
            NSDictionary *errorResponseDict = [NSJSONSerialization JSONObjectWithData:data
                                                                              options:NSJSONReadingAllowFragments
                                                                                error:&jsonError];
            if (jsonError != nil) {
                *error = responseError;
            }else{
                *error = [NSError errorWithResponse:errorResponseDict];
            }
        }else{
            *error = responseError;
        }
    }
    
    if (*error) {
        return responseObject;
    }else{
        if ([responseClass instancesRespondToSelector:@selector(initWithInfo:)] && [responseObject objectForKey:@"data"] != nil) {
            id obj = [[responseClass alloc] initWithInfo:responseObject[@"data"]];
            return obj;
        }else{
            *error = [NSError mappingError];
            return responseObject;
        }
    }
}

@end
