//
//  ConsumerGroup.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCConsumerGroupType.h>

/*!
 *  Consumer group
 */
@interface WFCConsumerGroup : NSObject

/*!
 *  Consumer Group ID
 */
@property (strong, nonatomic) NSString *consumerGroupId;

/*!
 *  Is this group active
 */
@property (nonatomic) bool activeFlag;

/*!
 *  Consumer Group type
 */
@property (strong, nonatomic) WFCConsumerGroupType *groupType;

@end
