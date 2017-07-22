//
//  MPactClient.h
//  MPactClient
//
//  Copyright (c) 2012 Motorola Solutions Inc. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Foundation/NSString.h>
#import <CoreLocation/CoreLocation.h>
#import "MPactServerInfo.h"
#import "MPactTag.h"

/**
 * Format of the beacon used by the locationing tag.
 */
typedef NS_ENUM(NSInteger, MPactBeaconType) {
    /** MPact custom format.  Battery life of the tag will be better than iBeacon. */
    MPactBeaconTypeBatterySave  = 1,
    /** Standard iBeacon format.  Major and Minor are combined to form the tag ID.  Battery life is not reported. */
    MPactBeaconTypeiBeacon      = 2,
    /** iBeacon format is used, however, the Major and Minor fields have specific meanings.  Battery life is included in the Minor field. */
    MPactBeaconTypeMPact        = 3
};

/**
 * iBeacon UUID that is used by MPact beacons when they come from the factory.
 */
extern NSString * const kDefaultMPactUUID;

/** Optional delegate methods for the MPact Client.
 *
 * Use these methods to receive extra information from the MPact Client.
 */
@protocol MPactClientDelegate <NSObject>
@optional

/**
 *  @method MPactClient:ClosestTag:
 *
 *  @param client       The object sending the message
 *  @param tag          The closest tag
 *
 *  @discussion     This method will be called at periodic intervals with the identity of the closest tag.  The method will stop being called when there is no closest tag identified. See MPactTag.
 *
 */
- (void)MPactClient:(id)client
        ClosestTag:(MPactTag *)tag;

/**
 *  @method MPactClient:didDetermineState:
 *
 *  @param client   The object sending the message
 *  @param state    This method will fire whenever the application crosses a border transition of the iBeacon region defined by the iBeaconUUID property of the MPactClient class.  Even applications that are in the background will become active for a few seconds when a transition occurs.  For a list of possible values, see the CLRegionState type.
 *
 *  @discussion     This method is active only if the MPactClient property beaconType is set to either MPactBeaconTypeiBeacon or MPactBeaconTypeMPact.
 *
 */
- (void)MPactClient:(id)client didDetermineState:(CLRegionState)state;

/**
 *  @method MPactClient:didDetermineState:Major:Minor:
 *
 *  @param client   The object sending the message
 *  @param state    This method will fire whenever the application crosses a border transition of an iBeacon region, including the region defined by the iBeaconUUID property of the MPactClient class.  Even applications that are in the background will become active for a few seconds when a transition occurs.  For a list of possible values, see the CLRegionState type.
 *  @param major    The major value of the region that triggered the event.  This value is set to nil if the region is not specific to a major value.
 *  @param minor    The minor value of the region that triggered the event.  This value is set to nil if the region is not specific to a minor value.
 *
 *  @discussion     This method is active only if the MPactClient property beaconType is set to either MPactBeaconTypeiBeacon or MPactBeaconTypeMPact.  A value of nil for both the Major and Minor indicates that the notification is for the region defined by the iBeaconUUID.
 *
 */
- (void)MPactClient:(id)client didDetermineState:(CLRegionState)state Major:(NSNumber *)major Minor:(NSNumber *)minor;

/**
 *  @method MPactClient:didChangeIBeaconUUID:
 *
 *  @param client       The object sending the message
 *  @param iBeaconUUID  The new value for the iBeaconUUID.
 *
 *  @discussion         This method will fire whenever the iBeacon UUID changes due to either the code in the application or a new configuration being downloaded from the MPact server.
 *
 */
- (void)MPactClient:(id)client didChangeIBeaconUUID:(NSUUID *)iBeaconUUID;

/**
 *  @method MPactClient:didChangeBeaconType:
 *
 *  @param client       The object sending the message
 *  @param beaconType   The new value for the beaconType.  For a list of possible values, see MPactBeaconType.
 *
 *  @discussion         This method will fire whenever the beacon type changes due to either the code in the application or a new configuration being downloaded from the MPact server.
 *
 */
- (void)MPactClient:(id)client didChangeBeaconType:(MPactBeaconType)beaconType;

@end

/** This class is for sending MPact position updates to the MPact Server.
 
 Partner applications should integrate this interface into their customer applications.
 */

@interface MPactClient : NSObject

/** Delegate for MPactClient.
 
 See also MPactClientDelegate.
 */
@property (nonatomic, weak) id <MPactClientDelegate> delegate;

/** Network information about the MPact Server.
 
 Refer to MPactServerInfo.
 */
@property MPactServerInfo* server;
/** The identity of this device.  The clientId will be sent to the MPact Server with the position updates.
 
 @discussion    This is a UUID that is generated when the application is installed and cannot be changed.
 */
@property (nonatomic, readonly) NSString * clientId;
/** Human readable name for the device.  The client name will be sent to the MPact Server with the position updates.
  */
@property (nonatomic) NSString * clientName;
/** The location format being used by the MPact tags.  See MPactBeaconType for valid settings.
 */
@property (nonatomic, assign) MPactBeaconType beaconType;
/** The attributes of the closest tag.  See MPactTag type.
 
 @discussion    The property will be nil when there is no closest tag identified.  The batteryLife will be set to -1 when the beaconType is set to MPactBeaconTypeiBeacon.
 */
@property (nonatomic, readonly) MPactTag *closestTag;
/** The UUID of the iBeacon tags.  This field is not used when beaconType is set to MPactBeaconTypeBatterySave.
 
 @discussion    This value needs to be explicitly set since the default value is nil.  No beacons will be detected when the value is set to nil.  The constant NSString kDefaultMPactUUID can be used to create a NSUUID if you are using MPact tags with the factory settings.
 */
@property (nonatomic) NSUUID *iBeaconUUID;

/** Factory function for creating the MPactClient object.
 
 @discussion  This function must be used to create the MPactClient object.  Directly calling alloc and init on the MPactClient class will result in a non-functional object.
 @return The MPactClient object
 */
+ (id) initClient;

/** Start scanning for MPact tags and send updates to the server.
 @return void
 */
- (void) Start;
/** Stop scanning for MPact tags and stop updates to the server.
 @return void
 */
- (void) Stop;
/** Version of the MPact API
 */
+ (NSString *)version;

@end
