//
//  WFCReservationInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 8/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  The available reservation trigger types.
 */
typedef NS_ENUM(NSInteger, WFCReservationTriggerType) {
    /*!
     *  Reservation event registration.
     */
    WFCReservationTriggerTypeRegister,
    /*!
     *  Reservation completion.
     */
    WFCReservationTriggerTypeComplete,
    /*!
     *  Reservation cancelled.
     */
    WFCReservationTriggerTypeCancel
};

/*!
 *  Reservation event trigger metadata class.
 */
@interface WFCReservationInfo : NSObject

/*!
 *  Sets the type type of reservation event to be triggered.
 */
@property (readonly) NSString * _Nonnull triggerType;

/*!
 *  The unique name of an event associated with a company or facility.
 */
@property (readonly) NSString * _Nonnull eventName;

/*!
 *  Creates and returns an initialized WFCReservationInfo instance with the triggerType and eventName provided.
 *
 *  @param triggerType Sets the type type of reservation event to be triggered.
 *  @param eventName   The unique name of an event associated with a company or facility.
 *
 *  @return A new initialized WFCReservationInfo instance.
 */
- (instancetype _Nonnull)initWithTriggerType:(WFCReservationTriggerType)triggerType eventName:(NSString * _Nonnull)eventName;

@end
