//
//  Phone.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Phone is used to store all phone related information.
 */
@interface WFCPhone : NSObject

/*!
 *  Phone number ID
 */
@property (strong, nonatomic) NSString *phoneId;

/*!
 *  Phone number.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *number;

/*!
 *  ConfirmedFlag.
 */
@property (nonatomic) bool confirmedPhone;

/*!
 *  Phone type.
 */
@property (strong, nonatomic) NSString *phoneTypeCode;

/*!
 *  Date on which account has been created for consumer successfully
 */
@property (strong, nonatomic) NSString *createdOn;

/*!
 *  The account by which consumer has been created
 */
@property (strong, nonatomic) NSString *createdBy;

/*!
 *  Date on which account information is modified for consumer
 */
@property (strong, nonatomic) NSString *modifiedOn;

/*!
 *  The account by which consumer information has been modified
 */
@property (strong, nonatomic) NSString *modifiedBy;

/*!
 *  Shows whether the account is active or inactive for consumer
 */
@property (nonatomic) bool activePhone;

@end
