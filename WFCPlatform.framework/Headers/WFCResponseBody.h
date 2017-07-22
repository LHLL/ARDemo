//
//  WFCResponseBody.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 12/16/15.
//  Copyright © 2015 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCResponseBody is a model for API responses.
 */
@interface WFCResponseBody : NSObject

/*!
 *  The status of a request. Indicates whether or not it was successful.
 */
@property (readonly) BOOL status;

/*!
 *  The body of an API response.
 */
@property (readonly) id _Nullable apiResponseBody;

/*!
 *  A list of errors returned from the API.
 */
@property (readonly) NSArray * _Nullable errorList;

/*!
 *  The raw API response.
 */
@property (readonly) NSDictionary * _Nullable rawResponse;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCResponseBody instance using the response and response type provided.
 *
 *  @param response     The response from a Wells Fargo Commerce Platform Service.
 *  @param responseType The type of the provided response.
 *
 *  @return A new initialized WFCResponseBody instance.
 */
- (instancetype _Nonnull)initWithResponse:(NSDictionary * _Nullable)response
                             responseType:(NSString * _Nonnull)responseType;

/*!
 *  Creates and returns a WFCResponseBody instance using the error list provided.
 *
 *  @param errorList A list of errors.
 *
 *  @return A new initialized WFCResponseBody instance.
 */
- (instancetype _Nonnull)initWithErrorList:(NSArray * _Nonnull)errorList;

@end
