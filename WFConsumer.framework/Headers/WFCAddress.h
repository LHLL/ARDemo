//
//  Address.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Address is used to store all address related information
 */
@interface WFCAddress : NSObject

/*!
 *  Address ID
 */
@property (strong, nonatomic) NSString *addressId;

/*!
 * First line of the address.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *line1;

/*!
 * Second line of the address.
 */
@property (strong, nonatomic) NSString *line2;

/*!
 * Third line of the address.
 */
@property (strong, nonatomic) NSString *line3;

/*!
 * Current City (part of address).
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *city;

/*!
 * Current Postal Code (part of address).
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *postalCode;

/*!
 * Current State Code (such as CA, AZ etc.., part of address).
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *stateCode;

/*!
 * Current Country (part of address).
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSString *countryCode;

/*!
 * addressTypeCode depending on address type (billing/shipping).
 */
@property (strong, nonatomic) NSString *addressTypeCode;

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
@property (nonatomic) bool activeAddress;

@end
