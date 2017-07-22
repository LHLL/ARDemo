//
//  WFCoreCompletion.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 8/3/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCErrorResponse.h>

/*!
 *  A block to execute upon completion of a request.
 *
 *  @param success   The BOOL returned from the request.
 *  @param error     Error response returned (nil if no errors).
 *  @param exception If an exception is caught, it will be returned (nil if no exception).
 */
typedef void (^WFCoreCPCompletionBool)(BOOL success, WFCErrorResponse * _Nullable error, NSException * _Nullable exception);

/*!
 *  A block to execute upon completion of a request.
 *
 *  @param response  The int returned from the request.
 *  @param error     Error response returned (nil if no errors).
 *  @param exception If an exception is caught, it will be returned (nil if no exception).
 */
typedef void (^WFCoreCPCompletionInt)(NSInteger response, WFCErrorResponse * _Nullable error, NSException * _Nullable exception);

/*!
 *  A block to execute upon completion of a request.
 *
 *  @param response  The NSString returned from the request.
 *  @param error     Error response returned (nil if no errors).
 *  @param exception If an exception is caught, it will be returned (nil if no exception).
 */
typedef void (^WFCoreCPCompletionStr)(NSString * _Nullable response, WFCErrorResponse * _Nullable error, NSException * _Nullable exception);
