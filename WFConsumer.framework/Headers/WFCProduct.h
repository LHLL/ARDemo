//
//  WFCProduct.h
//  WFReservation
//
//  Created by Vasikarla, Sindhu. on 7/19/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  A product
 */
@interface WFCProduct : NSObject

/*!
 *  Specifies the unique identifier representing the specific product associated with the event.
 */
@property (assign, nonatomic) NSInteger productId;

/*!
 *  Specifies the quantity of the specific product associated with the event. maxLength is 3
 */
@property (assign, nonatomic) NSInteger quantity;

/*!
 * Specifies the coupon code applied to the specific product associated with the event.
 */
@property (strong, nonatomic) NSString * _Nullable productDescription;

/*!
 *  Specifies the price of the the specific product associated with the event.
 */
@property (strong, nonatomic) NSString * _Nonnull price; 

/*!
 *  Creates and returns a WFCProduct instance using the response provided
 *
 *  @param response A response dictionary
 *
 *  @return A new instance
 */
- (instancetype _Nonnull)initWithResponse:(NSDictionary * _Nonnull)response;

/*!
 *  Convert product to dictionary
 *
 *  @return A dictionary with the product info
 */
- (NSDictionary * _Nonnull)toDictionary;

@end
