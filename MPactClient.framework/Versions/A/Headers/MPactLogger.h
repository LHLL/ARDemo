//
//  MPactLogger.h
//  MPactClient
//
//  Copyright (c) 2014 Motorola Solutions Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Debug logging Levels for the MPact SDK.
 * The MPactLogZone combined with the MPactLogLevel determine the amount of logging
 * messages that get generated.
 *
 * See MPactLogger class.
 */
typedef NS_ENUM(NSInteger, MPactLogLevel) {
    /** Highest Level.  Can't be filtered */
    MPactLogLevelCritical,
    /** The system did not function properly. */
    MPactLogLevelError,
    /** An unexpected event happened and there may have been an unintended side effect. */
    MPactLogLevelWarning,
    /** Informational messages */
    MPactLogLevelInfo,
    /** Low level debug messages */
    MPactLogLevelDebug,
    /** Extremely detailed and potentially high volume logging. */
    MPactLogLevelTrace,
    /** Not a valid logging level. */
    MPactLogLevelInvalid
};

/**
 * Available debug logging zones for the MPact SDK.
 * The MPactLogZone combined with the MPactLogLevel determine the amount of logging
 * messages that get generated.
 *
 * See MPactLogger class.
 */
typedef NS_ENUM(NSInteger, MPactLogZone) {
    /** Special enum for applying actions to all debug zones */
    MPactLogZoneAll,
    /** General logs about the SDK */
    MPactLogZoneGeneral,
    /** Logs specific to beacon tracking */
    MPactLogZoneBeacon,
    /** Logs specific to determining the closest beacon */
    MPactLogZoneWinner,
    /** Logs specific to communications with the MPact Server */
    MPactLogZoneServer,
    /** Invalid Zone */
    MPactLogZoneInvalid
};

/** Delegate methods for receiving logs from the MPactLogger.
 *
 * Use these methods to receive debug logging messages from the MPact SDK.
 * The delegate will only receive messages if the  setAppLoggingZone method
 * of the MPactLogger class is set to a high enough level for one of the logging zones.
 */
@protocol MPactLoggerDelegate <NSObject>
@required
/**
 *  @method MPactLogger:LogMessage
 *
 *  @param logger   The object sending the message
 *  @param zone     The zone where the message originated
 *  @param level    The severity of the message
 *  @param message  The log message
 *
 *  @discussion     Low level debugging messages from the MPact library
 *
 */
- (void)MPactLogger:(id)logger
               Zone:(MPactLogZone)zone
              Level:(MPactLogLevel)level
         LogMessage:(NSString *)message;

@end

/** This class is for enabling the generation of debug log messages by the MPact SDK.
 
 The app writer has the option of generating log messages that are sent to the console
 and/or directly to a class that implements the MPactLoggerDelegate methods.
 */
@interface MPactLogger : NSObject

/** Delegate for MPactLogger.
 
 See also MPactLoggerDelegate.
 */
@property (nonatomic, weak) id <MPactLoggerDelegate> delegate;

/** The MPactLogger object.
 
 Use this property to get an instance of the MPactLogger.  Do not use alloc or init methods.
 */
+ (MPactLogger *)sharedInstance;

/** Set the zones and levels to be used for logging to the system console.
 @param zone    The logging zone to change.  See MPactLogZone.
 @param level   The logging level requested for the zone.  See MPactLogLevel.
 */
- (void) setConsoleLoggingZone:(MPactLogZone)zone Level:(MPactLogLevel)level;

/** Get the system console logging level for the specified zone.
 @param zone    The logging zone to change.  See MPactLogZone.
 
 @return    The current logging level for the requested zone.  See MPactLogLevel
 */
- (MPactLogLevel) getConsoleLoggingZone:(MPactLogZone)zone;

/** Set the zones and levels to be used for logging to the MPactLoggerDelegate.
 @param zone    The logging zone to change.  See MPactLogZone.
 @param level   The logging level requested for the zone.  See MPactLogLevel.
 
 @discussion    Messages can only be received by the app if the MPactLoggerDelegate is implemented.
 */
- (void) setAppLoggingZone:(MPactLogZone)zone Level:(MPactLogLevel)level;

/** Get the MPactLoggerDelegate logging level for the specified zone.
 @param zone    The logging zone to change.  See MPactLogZone.
 
 @return    The current logging level for the requested zone.  See MPactLogLevel.
 */
- (MPactLogLevel) getAppLoggingZone:(MPactLogZone)zone;

@end
