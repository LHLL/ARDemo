//
//  Preference.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Preference is used to store all consumer preference information.
 */
@interface WFCPreference : NSObject

/*!
 * Yes or No depending on preference to receive email notification.
 */
@property (nonatomic) bool preferEmailFlag;

/*!
 * Yes or No depending on preference to receive sms notification.
 */
@property (nonatomic) bool preferSmsFlag;

/*!
 * Yes or No depending on preference to receive in app push notification notification.
 */
@property (nonatomic) bool preferAppFlag;

/*!
 * preferenceTypeCode.
 */
@property (nonatomic) NSInteger preferenceTypeCode;

@end
