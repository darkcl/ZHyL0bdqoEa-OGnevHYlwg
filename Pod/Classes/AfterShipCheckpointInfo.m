//
//  AfterShipCheckpointInfo.m
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import "AfterShipCheckpointInfo.h"
#import <KZPropertyMapper/KZPropertyMapper.h>

@implementation AfterShipCheckpointInfo

- (id)initWithInfo:(NSDictionary *)dict{
    if (self = [super init]) {
        [KZPropertyMapper mapValuesFrom:dict
                             toInstance:self
                           usingMapping:[self mapping]];
    }
    return self;
}

- (NSDictionary *)mapping{
    return @{@"created_at": KZCall(dateFromResponse:, createDate),
             @"slug": KZProperty(slug),
             @"checkpoint_time": KZCall(dateFromResponse:, checkpontTime),
             @"city": KZProperty(city),
             @"country_iso3": KZProperty(countryIso3),
             @"country_name": KZProperty(countryName),
             @"message": KZProperty(message),
             @"state": KZProperty(state),
             @"tag": KZProperty(tag),
             @"zip": KZProperty(zip)};
}

- (NSDate *)dateFromResponse:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSDate *result = [formatter dateFromString:string];
    if (!result) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        result = [formatter dateFromString:string];
        if (!result) {
            [formatter setDateFormat:@"yyyy-MM-dd"];
            result = [formatter dateFromString:string];
        }
    }
    return result;
}

@end
