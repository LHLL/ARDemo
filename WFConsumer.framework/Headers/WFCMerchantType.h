//
//  MerchantType.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Merchant Type
 */
@interface WFCMerchantType : NSObject

/*!
 *  Merchant Type Code
 */
@property (strong, nonatomic) NSString *merchantTypeCode;

/*!
 *  Description of merchant
 */
@property (strong, nonatomic) NSString *merchantDescription;

/*!
 *  Sort order
 */
@property (strong, nonatomic) NSString *sortOrder;

/*!
 *  Is this merchant active
 */
@property (nonatomic) bool activeFlag;

@end
