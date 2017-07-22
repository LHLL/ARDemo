//
//  WFCErrorDetails.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 7/28/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCErrorDetails is a model for a API error messages.
 */
@interface WFCErrorDetails : NSObject

/*!
 *  The code of an error.
 */
@property (readonly) NSInteger errorCode;

/*!
 *  The message of an error.
 */
@property (readonly) NSString * _Nonnull errorMessage;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCErrorDetails instance using the error details provided.
 *
 *  @param errorDetails The error details dictionary.
 *
 *  @return A new initialized WFCErrorDetails instance.
 */
- (instancetype _Nonnull)initWithErrorDetails:(NSDictionary * _Nullable)errorDetails;

@end
