//
//  AfterShipResponseSerializer.m
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import "AfterShipResponseSerializer.h"
#import "NSError+AfterShipKit.h"

@implementation AfterShipResponseSerializer

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    NSLog(@"test subclass");
    
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
    
    return responseObject;
}

@end
