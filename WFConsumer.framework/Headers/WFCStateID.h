//
//  StateID.h
//  WFConsumer
//
//  Created by Xu, Jay on 6/9/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  State Id
 */
@interface WFCStateID : NSObject

/*!
 *  Country code, for instance: US
 */
@property (strong, nonatomic) NSString *countryCode;

/*!
 *  State Code, for instace: NJ
 */
@property (strong, nonatomic) NSString *stateCode;

@end
