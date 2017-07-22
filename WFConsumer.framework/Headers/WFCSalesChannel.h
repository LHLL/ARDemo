//
//  WFCSalesChannel.h
//  WFReservation
//
//  Created by Xu, Jay on 9/6/16.
//  Copyright © 2016 Wells Fargo Organization. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  Sales channel
 */
@interface WFCSalesChannel : NSObject

/*!
 *  Sales channel ID
 */
@property (assign, nonatomic) NSInteger channelId;

/*!
 *  Sales channel name
 */
@property (strong, nonatomic) NSString * _Nonnull channelName;

/*!
 *  Creates and returns a WFCSalesChannel instance using the response provided
 *
 *  @param response Reponse from Base SDK
 *
 *  @return An instance of WFCSalesChannel
 */
-(instancetype _Nonnull)initWithResponse:(NSDictionary * _Nonnull)response;

@end
