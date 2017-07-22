//
//  WFCPurchaseInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 4/5/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Purchase event trigger metadata class.
 */
@interface WFCPurchaseInfo : NSObject

/*!
 *  The unique name of a merchant associated with a transaction.
 */
@property (readonly) NSString * _Nonnull merchantName;

/*!
 *  The amount of the transaction.
 */
@property (readonly) double transactionAmount;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns an initialized WFCPurchaseInfo instance with the merchantName and transactionAmount provided.
 *
 *  @param merchantName      The unique name of a merchant associated with a transaction.
 *  @param transactionAmount The amount of the transaction.
 *
 *  @return A new initialized WFCPurchaseInfo instance.
 */
- (instancetype _Nonnull)initWithMerchantName:(NSString * _Nonnull)merchantName transactionAmount:(double)transactionAmount;

@end
