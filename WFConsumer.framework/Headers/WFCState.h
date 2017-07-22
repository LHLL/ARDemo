//
//  State.h
//  WFConsumer
//
//  Created by Xu, Jay on 6/9/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <WFConsumer/WFCBaseType.h>
#import <WFConsumer/WFCStateID.h>

/*!
 *  State
 */
@interface WFCState : WFCBaseType

/*!
 *  State ID
 */
@property (strong, nonatomic) WFCStateID *stateID;

@end
