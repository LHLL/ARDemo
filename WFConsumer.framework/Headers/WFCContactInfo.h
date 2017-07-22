//
//  ContactInfo.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCAddress.h>
#import <WFConsumer/WFCEmail.h>
#import <WFConsumer/WFCPhone.h>

/*!
 *  ContactInfo is used to store all consumer preference information.
 */
@interface WFCContactInfo : NSObject

/*!
 * contactID.
 */
@property (strong, nonatomic) NSString *contactId;

/*!
 * contactTypeCode.
 */
@property (strong, nonatomic) NSString *contactTypeCode;

/*!
 *  Email object is used to store all email related information.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) WFCEmail *emailInfo;

/*!
 *  Phone object is used to store all phone related information.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) WFCPhone *phoneInfo;

/*!
 *  Address object is used to store all address related information.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) WFCAddress *addressInfo;

@end
