//
//  WFCErrorFields.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 7/28/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCFieldValuePairs.h>

/*!
 *  WFCErrorFields is a model for API error fields.
 */
@interface WFCErrorFields : NSObject

/*!
 *  Generic text about field(s) that enforce the error.
 */
@property (readonly) NSString * _Nullable text;

/*!
 *  A list of field value pairs.
 */
@property (readonly) NSArray<WFCFieldValuePairs *> * _Nullable fieldsValues;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCErrorFields instance using the error fields provided.
 *
 *  @param errorFields The error fields dictionary.
 *
 *  @return A new initialized WFCErrorFields instance.
 */
- (instancetype _Nonnull)initWithErrorFields:(NSDictionary * _Nullable)errorFields;

@end
