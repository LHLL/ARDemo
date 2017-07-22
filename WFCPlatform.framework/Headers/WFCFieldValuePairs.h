//
//  WFCFieldValuePairs.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 7/28/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCFieldValuePairs is a model for API errorFields field value pairs.
 */
@interface WFCFieldValuePairs : NSObject

/*!
 *  An error field.
 */
@property (readonly) NSString * _Nullable field;

/*!
 *  An error value.
 */
@property (readonly) NSString * _Nullable value;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCFieldValuePairs instance using the field value pair provided.
 *
 *  @param fieldValuePair The field value pair dictionary.
 *
 *  @return A new initialized WFCFieldValuePairs instance.
 */
- (instancetype _Nonnull)initWithFieldValuePair:(NSDictionary * _Nullable)fieldValuePair;

@end
