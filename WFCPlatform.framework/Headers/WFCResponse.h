//
//  WFCResponse.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 7/26/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCErrorResponse.h>

/*!
 *  WFCResponse is a model for API responses.
 */
@interface WFCResponse : NSObject

/*!
 *  The HTTP response status code.
 */
@property (readonly) NSInteger httpStatusCode;

/*!
 *  The HTTP response headers.
 */
@property (readonly) NSDictionary * _Nullable headers;

/*!
 *  The successful API response (nil if error).
 */
@property (readonly) id _Nullable body;

/*!
 *  The error API response (nil if successful).
 */
@property (readonly) WFCErrorResponse * _Nullable error;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns an initialized WFCResponse instance using the response provided.
 *
 *  @param response       The response dictionary.
 *  @param httpStatusCode The HTTP response status code.
 *  @param headers        The HTTP response headers.
 *
 *  @return A new initialized WFCResponse instance.
 */
- (instancetype _Nonnull)initWithResponse:(id _Nullable)response
                           httpStatusCode:(NSInteger)httpStatusCode
                                  headers:(NSDictionary * _Nullable)headers;

/*!
 *  Creates and returns an initialized WFCResponse instance using the error messages provided.
 *
 *  @param errorMessages A list of error messages.
 *
 *  @return A new initialized WFCResponse instance.
 */
- (instancetype _Nonnull)initWithErrorMessages:(NSArray<NSString *> * _Nonnull)errorMessages;

@end