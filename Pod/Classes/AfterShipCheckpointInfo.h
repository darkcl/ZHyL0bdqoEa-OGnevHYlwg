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

/**
 *  Date and time of the tracking created.
 */
@property (nonatomic, strong) NSDate *createDate;

/**
 *  The unique code of courier for this checkpoint message. Get courier slug here ( https://www.aftership.com/docs/api/4/couriers )
 */
@property (nonatomic, strong) NSString *slug;

/**
 *  Date and time of the checkpoint, provided by courier
 */
@property (nonatomic, strong) NSDate *checkpontTime;

/**
 *  Location info (if any)
 */
@property (nonatomic, strong) NSString *city;

/**
 *  Country ISO Alpha-3 (three letters) of the checkpoint
 */
@property (nonatomic, strong) NSString *countryIso3;

/**
 *  Country name of the checkpoint, may also contain other location info.
 */
@property (nonatomic, strong) NSString *countryName;

/**
 *  Checkpoint message
 */
@property (nonatomic, strong) NSString *message;

/**
 *  Location info (if any)
 */
@property (nonatomic, strong) NSString *state;

/**
 *  Current status of checkpoint
 */
@property (nonatomic, strong) NSString *tag;

/**
 *  Location info (if any)
 */
@property (nonatomic, strong) NSString *zip;

@end
