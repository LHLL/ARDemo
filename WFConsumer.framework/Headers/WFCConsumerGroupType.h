//
//  ConsumerGroupType.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Group type
 */
@interface WFCConsumerGroupType : NSObject

/*!
 *  Consumer group code
 */
@property (strong, nonatomic) NSString *groupCode;

/*!
 *  Is this group active
 */
@property (nonatomic) bool activeFlag;

/*!
 *  Description of consumer group
 */
@property (strong, nonatomic) NSString *groupDescription;

/*!
 *  Shows the sort order
 */
@property (strong, nonatomic) NSString *sortOrder;

@end
