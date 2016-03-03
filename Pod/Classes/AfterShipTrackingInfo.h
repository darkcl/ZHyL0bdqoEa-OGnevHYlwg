//
//  AfterShipTrackingInfo.h
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import <Foundation/Foundation.h>
#import "AfterShipBaseObject.h"
#import "AfterShipCheckpointInfo.h"

@interface AfterShipTrackingInfo : AfterShipBaseObject

@property (nonatomic, strong) NSString *trackingId;
@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSDate *updateDate;

@property (nonatomic, strong) NSString *trackingNumber;
@property (nonatomic, strong) NSString *trackingAccountNumber;
@property (nonatomic, strong) NSString *trackingPostalCode;
@property (nonatomic, strong) NSDate *trackingShipDate;
@property (nonatomic, strong) NSString *trackingKey;
@property (nonatomic, strong) NSString *trackingDestinationCountry;

@property (nonatomic, strong) NSString *slug;
@property BOOL isActive;
@property (nonatomic, strong) NSArray<NSString *> *androidDeviceToken;
@property (nonatomic, strong) NSDictionary *customFields;
@property (nonatomic, strong) NSString *customerName;
@property (nonatomic, strong) NSNumber *deliveryTime;
@property (nonatomic, strong) NSString *destinationCountryIso3;
@property (nonatomic, strong) NSArray<NSString *> *emails;
@property (nonatomic, strong) NSString *expectedDelivery;
@property (nonatomic, strong) NSArray<NSString *> *iosDeviceIds;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderIdPath;
@property (nonatomic, strong) NSString *originCountryIso3;
@property (nonatomic, strong) NSString *uniqueToken;
@property (nonatomic, strong) NSNumber *shipmentPackageCount;
@property (nonatomic, strong) NSString *shipmentType;
@property (nonatomic, strong) NSNumber *shipmentWeight;
@property (nonatomic, strong) NSString *shipmentWeightUnit;
@property (nonatomic, strong) NSString *signedBy;
@property (nonatomic, strong) NSArray<NSString *> *smses;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSNumber *trackedCount;
@property (nonatomic, strong) NSArray<AfterShipCheckpointInfo *> *checkpoints;

- (id)init NS_UNAVAILABLE;
- (id)initWithTrackingNumber:(NSString * _Nonnull)trackingNum;

- (NSDictionary *)dictionaryRepresentation;

@end
