//
//  WFCEventInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 4/5/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCPurchaseInfo.h>
#import <WFCPlatform/WFCReservationInfo.h>

/*!
 *  Base class for all other event trigger metadata classes to inherit from.
 */
@interface WFCEventTriggerInfo : NSObject

/*!
 *  The action of the triggered event.
 */
@property (readonly) NSString * _Nonnull eventAction;

/*!
 *  The metadata of the triggered event.
 */
@property (readonly) NSDictionary * _Nonnull eventData;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Initializes the WFCEventTriggerInfo instance for a registration event.
 *
 *  @return A new initialized WFCEventTriggerInfo instance for registration events.
 */
- (instancetype _Nonnull)initForRegistration;

/*!
 *  Initializes the WFCEventTriggerInfo instance for a purchase event.
 *
 *  @param info The merchantName and transactionAmount of the purchase.
 *
 *  @return A new initialized WFCEventTriggerInfo instance for purchase events.
 */
- (instancetype _Nonnull)initWithPurchaseInfo:(WFCPurchaseInfo * _Nonnull)info;

/*!
 *  Initializes the WFCEventTriggerInfo instance for a reservation event.
 *
 *  @param info The triggerType and eventName of the reservation event.
 *
 *  @return A new initialized WFCEventTriggerInfo instance for reservation events.
 */
- (instancetype _Nonnull)initWithReservationInfo:(WFCReservationInfo * _Nonnull)info;

@end