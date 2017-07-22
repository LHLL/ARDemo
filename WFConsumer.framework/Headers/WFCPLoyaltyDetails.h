//
//  WFCPLoyaltyDetails.h
//  WFConsumer
//
//  Created by Aggarwal, Vishal on 1/12/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Loyalty Point Type
 */
typedef NS_ENUM(NSInteger, WFCLoyaltyPointType) {
    /*!
     *  Redeem loyalty points
     */
    WFCLoyaltyPointTypeRedeemed,
    /*!
     *  Newly earned loyalty points
     */
    WFCLoyaltyPointTypeEarned,
    /*!
     *  Loyalty points balance
     */
    WFCLoyaltyPointTypeBalance
};

/*!
 *  WFCPLoyaltyDetails is used to store all of consumer Loyalty Details.
 */
@interface WFCPLoyaltyDetails : NSObject

/*!
 * loyaltyId is received at the time of registration/authentication.
 */
@property (strong, nonatomic) NSString * _Nonnull loyaltyId;

/*!
 * pointType (redeemed, earned, balance) has current loyalty points information of the user.
 */
@property (assign, nonatomic) WFCLoyaltyPointType pointType;

@end
