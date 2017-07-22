//
//  ConsumerMerchantType.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCMerchantType.h>

/*!
 *  Consumer Merchant type
 */
@interface WFCConsumerMerchantType : NSObject

/*!
 *  Consumer merchant type ID
 */
@property (strong, nonatomic) NSString *consumerMerchantTypeId;

/*!
 *  Is this merchant active
 */
@property (nonatomic) bool activeFlag;

/*!
 *  Merchant type
 */
@property (strong, nonatomic) WFCMerchantType *merchantType;

@end
