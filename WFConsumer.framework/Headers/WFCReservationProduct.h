//
//  WFCReservationProduct.h
//  WFReservation
//
//  Created by Xu, Jay on 9/1/16.
//  Copyright © 2016 Wells Fargo Organization. All rights reserved.
//

#import <WFConsumer/WFCSalesChannel.h>
#import <WFConsumer/WFCProductCatagory.h>
#import <WFConsumer/WFCProduct.h>

/*!
 *  Event associated product
 */
@interface WFCReservationProduct : WFCProduct

/*!
 *  Product Name
 */
@property (strong, nonatomic) NSString * _Nonnull name;

/*!
 *  Event start date
 */
@property (strong, nonatomic) NSString * _Nonnull startDate;

/*!
 *  Event end date
 */
@property (strong, nonatomic) NSString * _Nonnull endDate;

/*!
 *  TimeZone like "PST"
 */
@property (strong, nonatomic) NSString * _Nonnull timeZone;

/*!
 *  Product catagory
 */
@property (strong, nonatomic) NSArray<WFCProductCatagory *> * _Nonnull categories;

/*!
 *  Short description of a product, consider this as Tag or Label on a product in the real world.
 */
@property (strong, nonatomic) NSString * _Nullable shortDescription;

/*!
 *  Full description of a product
 */
@property (strong, nonatomic) NSString * _Nonnull prodDesc;

/*!
 *  Is this product tax free
 */
@property (assign, nonatomic) BOOL taxable;

/*!
 *  Where is this product available, like "WEB"
 */
@property (strong, nonatomic) NSArray<WFCSalesChannel *> * _Nonnull channels;

/*!
 *  Image url
 */
@property (strong, nonatomic) NSString * _Nonnull imageAddress;

/*!
 *  Image description
 */
@property (strong, nonatomic) NSString * _Nonnull imageText;

/*!
 *  SKU of the specific product. Allowed alphanumeric (except O, I and L letters) and hyphen (-) character; first character must be a letter.
 */
@property (strong, nonatomic) NSString * _Nonnull sku;

/*!
 *  Product status
 */
@property (strong, nonatomic) NSString * _Nonnull status;

/*!
 *  Product status code
 */
@property (strong, nonatomic) NSString * _Nonnull statusCode;

/*!
 *  Date on which account has been created for consumer successfully
 */
@property (strong, nonatomic) NSString * _Nonnull createOn;

/*!
 *  The account by which consumer has been created
 */
@property (strong, nonatomic) NSString * _Nonnull createBy;

/*!
 *  Creates and returns a WFCReservationProduct instance using the response provided
 *
 *  @param response Response Dictionary
 *
 *  @return An instance of WFCReservationProduct class
 */
- (instancetype _Nonnull)initWithResponse:(NSDictionary * _Nonnull)response;

/*!
 *  Reverse object to dictionary for request
 *
 *  @return Dictorinary for Http Header
 */
- (NSDictionary * _Nonnull)reverseToDictionary;
@end
