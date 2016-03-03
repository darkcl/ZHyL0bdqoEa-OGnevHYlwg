//
//  AfterShipTrackingInfo.m
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import "AfterShipTrackingInfo.h"

#import <KZPropertyMapper/KZPropertyMapper.h>

#import "AfterShipBaseObject.h"

@implementation AfterShipTrackingInfo

+ (NSDictionary *)objectMapping{
    return [[AfterShipTrackingInfo new] mapping];
}

+ (id)modelWithInfo:(NSDictionary *)dict{
    return [[AfterShipTrackingInfo alloc] initWithInfo:dict];
}

- (id)initWithInfo:(NSDictionary *)dict{
    if (self = [super init]) {
        [KZPropertyMapper mapValuesFrom:dict[@"tracking"]
                             toInstance:self
                           usingMapping:[self mapping]];
    }
    return self;
}

- (NSDictionary *)mapping{
    return @{@"created_at": KZCall(dateFromResponse:, createDate),
             @"updated_at": KZCall(dateFromResponse:, updateDate),
             @"id": KZProperty(trackingId),
             @"tracking_postal_code": KZProperty(trackingPostalCode),
             @"tracking_ship_date": KZCall(shippingDateFromResponse:, trackingShipDate),
             @"tracking_account_number": KZProperty(trackingAccountNumber),
             @"tracking_key": KZProperty(trackingKey),
             @"tracking_destination_country": KZProperty(trackingDestinationCountry),
             @"slug": KZProperty(slug),
             @"active": KZProperty(isActive),
             @"android": KZCall(stringOrArrayToArray:, androidDeviceToken),
             @"custom_fields": KZProperty(customFields),
             @"customer_name": KZProperty(customerName),
             @"delivery_time": KZProperty(deliveryTime),
             @"destination_country_iso3": KZProperty(destinationCountryIso3),
             @"emails": KZCall(stringOrArrayToArray:, emails),
             @"expected_delivery":KZProperty(expectedDelivery),
             @"ios": KZCall(stringOrArrayToArray:, iosDeviceIds),
             @"order_id": KZProperty(orderId),
             @"order_id_path": KZProperty(orderIdPath),
             @"origin_country_iso3": KZProperty(originCountryIso3),
             @"unique_token": KZProperty(uniqueToken),
             @"shipment_package_count": KZProperty(shipmentPackageCount),
             @"shipment_type": KZProperty(shipmentType),
             @"shipment_weight": KZProperty(shipmentWeight),
             @"shipment_weight_unit":KZProperty(shipmentWeightUnit),
             @"signed_by": KZProperty(signedBy),
             @"smses":KZCall(stringOrArrayToArray:, smses),
             @"source": KZProperty(source),
             @"tag": KZProperty(tag),
             @"title": KZProperty(title),
             @"tracked_count": KZProperty(trackedCount),
             @"checkpoints": KZCall(mapCheckPointInfoWithArray:, checkpoints)};
}

- (NSArray *)stringOrArrayToArray:(id)value{
    if ([value isKindOfClass:[NSArray class]]) {
        return value;
    }else{
        return @[value];
    }
}

- (NSDate *)shippingDateFromResponse:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter dateFromString:string];
}

- (NSDate *)dateFromResponse:(NSString *)string{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    return [formatter dateFromString:string];
}

- (NSArray<AfterShipCheckpointInfo *> *)mapCheckPointInfoWithArray:(NSArray<NSDictionary *> *)dictArray{
    NSMutableArray *anArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *infoDict in dictArray) {
        [anArray addObject:[[AfterShipCheckpointInfo alloc] initWithInfo:infoDict]];
    }
    
    return anArray;
}

@end
