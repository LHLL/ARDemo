//
//  WFCErrorResponse.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 7/28/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCErrorFields.h>
#import <WFCPlatform/WFCErrorDetails.h>

/*!
 *  WFCErrorResponse is a model for API error responses.
 */
@interface WFCErrorResponse : NSObject

/*!
 *  Standard HTTP 400s or 500s error responses.
    400 - Bad Request
    401 - Unauthorized
    403 - Forbidden
    404 - Not Found
    405 - Method Not Allowed
    500 - Internal Server Error
    503 - Service Unavailable
 */
@property (readonly) NSInteger httpResponseCode;

/*!
 *  A list of errors.
 */
@property (readonly) NSArray<WFCErrorDetails *> * _Nonnull errorDetails;

/*!
 *  A nice, user-friendly description of the error.
 */
@property (readonly) NSString * _Nullable userMessage;

/*!
 *  Generic text about field(s) that enforce the error.
 */
@property (readonly) WFCErrorFields * _Nullable errorFields;

/*!
 *  More info about the error.
 */
@property (readonly) NSString * _Nullable errorMoreInfo;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCErrorResponse instance using the response provided.
 *
 *  @param errorResponse The error response dictionary.
 *
 *  @return A new initialized WFCErrorResponse instance.
 */
- (instancetype _Nonnull)initWithErrorResponse:(NSDictionary * _Nullable)errorResponse;

/*!
 *  Creates and returns a WFCErrorResponse instance using the error messages provided.
 *
 *  @param errorMessages A list of error messages.
 *
 *  @return A new initialized WFCErrorResponse instance.
 */
- (instancetype _Nonnull)initWithErrorMessages:(NSArray<NSString *> * _Nonnull)errorMessages;

@end
