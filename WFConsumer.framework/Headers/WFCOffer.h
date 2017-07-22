//
//  WFCOffer.h
//  WFConsumer
//
//  Created by Xu, Jay on 8/4/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/OfferDetails.h>

/*!
 *  WFCOffer
 */
@interface WFCOffer : NSObject

/*!
 *  Offer id used for getOfferDetailsWithOfferId
 */
@property (strong, nonatomic) NSString *consumerOfferId;

/*!
 *  Offer id used to get offer
 */
@property (strong, nonatomic) NSString *offerId;

/*!
 *  Offer name
 */
@property (strong, nonatomic) NSString *offerName;

/*!
 *  Offer decription
 */
@property (strong, nonatomic) NSString *offerDescription;

/*!
 *  Promotion code
 */
@property (strong, nonatomic) NSString *promoCode;

/*!
 *  OfferDetails
 */
@property (strong, nonatomic) OfferDetails *offerDetails;

/*!
 *  Offer Code
 */
@property (strong, nonatomic) NSString *offerCode;

/*!
 *  Init with WFCResponseBody.apiResponseBody
 *
 *  @param response WFCResponseBody.apiResponseBody
 *
 *  @return An instance of Offer class
 */
- (instancetype)initWithResponse:(NSDictionary *)response;
@end
