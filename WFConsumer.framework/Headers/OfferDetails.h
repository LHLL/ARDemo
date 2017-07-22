//
//  OfferDetails.h
//  WFConsumer
//
//  Created by Xu, Jay on 8/4/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCReservationProduct.h>
#import <WFConsumer/OfferRules.h>
#import <WFConsumer/OfferType.h>

/*!
 *  Offer Details
 */
@interface OfferDetails : NSObject

/*!
 *  OfferRules
 */
@property (strong, nonatomic) OfferRules *rule;

/*!
 *  OfferType
 */
@property (strong, nonatomic) OfferType *type;

/*!
 *  An array of Product
 */
@property (strong, nonatomic) NSArray<WFCReservationProduct *> *products;

/*!
 *  Offer thumbNail image url
 */
@property (strong, nonatomic) NSString *imageURL;

@end
