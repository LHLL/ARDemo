//
//  BaseType.h
//  WFConsumer
//
//  Created by Xu, Jay on 6/9/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Base type
 */
@interface WFCBaseType : NSObject

/*!
 *  Is this type active
 */
@property (nonatomic) bool activeFlag;

/*!
 *  Description of this type
 */
@property (strong, nonatomic) NSString *typeDescription;

/*!
 *  Sort order
 */
@property (nonatomic) NSInteger sortOrder;

@end
