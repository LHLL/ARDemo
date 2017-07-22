//
//  WFCoreConsumerInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 1/6/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCoreConsumerInfo provides a base object for other Wells Fargo SDKs to subclass when necessary.
 */
@interface WFCoreConsumerInfo : NSObject

/*!
 *  The preferred prefix of a consumer.
 */
@property (strong, nonatomic) NSString * _Nullable prefix;

/*!
 *  The preferred first name of a consumer.
 */
@property (strong, nonatomic) NSString * _Nonnull firstName;

/*!
 *  The preferred middle name of a consumer.
 */
@property (strong, nonatomic) NSString * _Nullable middleName;

/*!
 *  The preferred last name of a consumer.
 */
@property (strong, nonatomic) NSString * _Nonnull lastName;

/*!
 *  The preferred suffix of a consumer.
 */
@property (strong, nonatomic) NSString * _Nullable suffix;

/*!
 *  Uniquely identifies a consumer of the app.
 */
@property (assign, nonatomic) NSInteger consumerID;

@end
