//
//  OfferRules.h
//  WFConsumer
//
//  Created by Xu, Jay on 8/4/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Offer rule
 */
@interface OfferRules : NSObject

/*!
 *  Individual redeem limit
 */
@property (strong, nonatomic) NSString *redeemLimit;

/*!
 *  Max transaction amount
 */
@property (strong, nonatomic) NSString *transactionLimit;

/*!
 *  Min purchase amount
 */
@property (strong, nonatomic) NSString *minPurchaseLimit;

/*!
 *  Can use with other offer or not
 */
@property (nonatomic) bool combinable;

@end
