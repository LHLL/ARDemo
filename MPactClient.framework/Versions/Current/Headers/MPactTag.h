//
//  MPactTag.h
//  MPactClient
//
//  Copyright (c) 2014 Motorola Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class holds the properties that describe the state of an MPact Tag.
 
 Refer to MPactClient
 */
@interface MPactTag : NSObject

/** The ID that is advertised in the beacon.
 
 @discussion    This value may be different than the manufacturingID.  For an iBeacon, for example, this value is the combination of the Major and Minor fields.
 */
@property NSString *tagID;

/** RSSI of the closest tag
 */
@property NSInteger rssi;

/** Estimated percentage of remaining life in the tag's battery
 
 @discussion    The batteryLife will be set to -1 when the beaconType is set to MPactBeaconTypeiBeacon.
 */
@property NSInteger batteryLife;

/** The MAC based ID of the tag that was stored in the MPact Server during installation.
 
 @discussion    This property is dependent upon information retrieved from the MPact Server.  This property is set to nil if the client hasn't been able to establish a connection with the MPact server.
 */
@property NSString *manufacturingID;

@end
