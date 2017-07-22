//
//  WFCProductCatagory.h
//  WFReservation
//
//  Created by Xu, Jay on 9/6/16.
//  Copyright © 2016 Wells Fargo Organization. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Product Category
 */
@interface WFCProductCatagory : NSObject

/*!
 *  Catagory name
 */
@property (strong, nonatomic) NSString * _Nonnull catagoryName;

/*!
 *  Catagory Id
 */
@property (assign, nonatomic) NSInteger catagoryId;

/*!
 *  Creates and returns a WFCProductCatagory instance using the response provided
 *
 *  @param response Response Dictionary
 *
 *  @return An instance of WFCProductCatagory class
 */
-(instancetype _Nonnull)initWithResponse:(NSDictionary * _Nonnull)response;

@end
