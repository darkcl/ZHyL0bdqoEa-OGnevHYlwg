//
//  AfterShipCheckpointInfo.h
//  Pods
//
//  Created by Yeung Yiu Hung on 2/3/2016.
//
//

#import <Foundation/Foundation.h>
#import "AfterShipBaseObject.h"

@interface AfterShipCheckpointInfo : AfterShipBaseObject

@property (nonatomic, strong) NSDate *createDate;
@property (nonatomic, strong) NSString *slug;
@property (nonatomic, strong) NSDate *checkpontTime;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *countryIso3;
@property (nonatomic, strong) NSString *countryName;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *zip;

@end
