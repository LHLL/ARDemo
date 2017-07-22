//
//  OfferType.h
//  WFConsumer
//
//  Created by Xu, Jay on 8/4/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Offer type
 */
@interface OfferType : NSObject

/*!
 *  Decription of offer, eg:"Percentage off"
 */
@property (strong, nonatomic) NSString *typeDescription;

/*!
 *  Number of percentage
 */
@property (strong, nonatomic) NSString *percentOff;

/*!
 *  Number of amount
 */
@property (strong, nonatomic) NSString *amountOff;

/*!
 *  Punch card number
 */
@property (strong, nonatomic) NSString *cardNumber;

/*!
 *  Loyalty amount
 */
@property (strong, nonatomic) NSString *loyaltyPoint;

@end
