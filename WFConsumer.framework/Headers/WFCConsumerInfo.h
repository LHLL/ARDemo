//
//  WFCConsumerInfo.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/19/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <WFCPlatform/WFCPlatform.h>
#import <WFConsumer/WFCPersonalInfo.h>
#import <WFConsumer/WFCPreference.h>
#import <WFConsumer/WFCPLoyaltyDetails.h>

/*!
 *  WFCConsumerInfo is used to store all of consumer CDM profile information.
 */
@interface WFCConsumerInfo : WFCoreConsumerInfo

/*!
 * number code depending upon user account status.
 */
@property (strong, nonatomic) NSString *accountStatusCode;

/*!
 * To check if account is active or inactive.
 */
@property (nonatomic) bool activeAccount;

/*!
 * Use to check the reachability of a given host name.
 */
@property (strong, nonatomic) NSString *consumerTypeCode;

/*!
 * consumerGroupCodes based on preferences selected during registraton or profile update.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSMutableArray *consumerGroupCodes;

/*!
 * Merchant Types based on selection during registraton or profile update.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) NSMutableArray *merchantTypes;

/*!
 * personalInfo object which will hold all consumer personal information.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) WFCPersonalInfo *personalInfo;

/*!
 * preference object which will hold all consumer preference information.
 *  @discussion Mandatory when signUp
 */
@property (strong, nonatomic) WFCPreference *preference;

/*!
 * LoyaltyDetails object which will hold LoyaltyPoints, LoyaltyStatus, PointType information.
 */
@property (nonatomic, strong) WFCPLoyaltyDetails *loyaltyDetails;

/*!
 *  Init method
 *
 *  @return An instance of WFConsumerInfo class
 */
-(instancetype)initWithResponse:(NSDictionary *)response;

@end
