//
//  Email.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Email is used to store all email related information.
 */
@interface WFCEmail : NSObject

/*!
 *  Email address ID
 */
@property (strong, nonatomic) NSString *addressId;

/*!
 *  Email address
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *address;

/*!
 * ConfirmedFlagEmail.
 */
@property (nonatomic) bool confirmedEmail;

/*!
 * EmailAddressTypeCode.
 */
@property (strong, nonatomic) NSString *addressTypeCode;

/*!
 *  Create time
 */
@property (strong, nonatomic) NSString *createdOn;

/*!
 *  Create person name
 */
@property (strong, nonatomic) NSString *createdBy;

/*!
 *  Last modification time
 */
@property (strong, nonatomic) NSString *modifiedOn;

/*!
 *  Last modification person name
 */
@property (strong, nonatomic) NSString *modifiedBy;

/*!
 *  Is email active
 */
@property (nonatomic) bool activeEmail;

@end
