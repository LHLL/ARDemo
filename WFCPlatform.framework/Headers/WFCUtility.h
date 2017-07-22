//
//  WFCUtility.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 12/15/15.
//  Copyright © 2015 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCUtility provides convenience methods for Wells Fargo SDKs.
 */
@interface WFCUtility : NSObject

#pragma mark - Validation

#pragma mark String

/*!
 *  Checks whether or not a string is valid.
 *
 *  @param string The string to be checked.
 *
 *  @return Returns whether or not the string is valid.
 */
+ (BOOL)stringIsValid:(NSString * _Nullable)string;

/*!
 *  Checks whether or not a string matches a given regular expression.
 *
 *  @param regex  The regular expression to compare to the string.
 *  @param string The string to compare to the regular expression.
 *
 *  @return Returns whether or not the string matches the regular expression.
 */
+ (BOOL)stringMatchesRegex:(NSString * _Nonnull)regex string:(NSString * _Nonnull)string;

#pragma mark Safety

/*!
 *  Checks whether or not a block of code can safely execute.
 *
 *  @param code            The block of code to be checked.
 *  @param handleException A block of code executed if an exception is caught.
 *  @code  - (void)doStuff:(WFCoreCPCompletionBool)completion
  {
      [WFCUtility safetyCheck:^{
          //Do something here, an exception will be thrown if not safe
          //Do not execute any external completion blocks here
          NSDictionary *body = @{};
 
          [self.webServiceHandler requestWithPath:@"path"
                               contextMessageType:@"messageType"
                                             body:body
                                       completion:^(id _Nonnull response) {
                                           completion(responseBody.status, responseBody.errorList, nil);
                                       }];
      } handleException:^(NSException *exception) {
          //If exception is caught, return it to the external completion
          completion(NO, nil, exception);
      }];
  }
 */
+ (void)safetyCheck:(void(^ _Nonnull)())code
    handleException:(void(^ _Nonnull)(NSException * _Nonnull exception))handleException;

/*!
 *  Checks for a null value and returns nil instead.
 *
 *  @param value The value to be checked.
 *
 *  @return Returns a proper value or nil.
 */
+ (id _Nullable)getNonNullValue:(id _Nullable)value;

#pragma mark Add Parameters

/*!
 *  Checks if the parameter is nil, otherwise adds it to the dictionary. Empty Strings @"" will not be added.
 *
 *  @param parameter The parameter to add.
 *  @param key       The key to set the parameter for.
 *  @param dict      The dictionary to add the key-value pair to.
 *
 *  @return Returns whether or not the key-value pair was successfully added.
 */
+ (BOOL)addParameter:(id _Nullable)parameter
              forKey:(NSString * _Nonnull)key
        toDictionary:(NSMutableDictionary * _Nullable)dict;

/*!
 *  Checks if the parameter is nil, otherwise adds it to the array. Empty Strings @"" will not be added.
 *
 *  @param parameter The parameter to add.
 *  @param array     The array to add the parameter to.
 *
 *  @return Returns whether or not the parameter was successfully added.
 */
+ (BOOL)addParameter:(id _Nullable)parameter toArray:(NSMutableArray * _Nullable)array;

#pragma mark - Convenience

#pragma mark Response Status

/*!
 *  Checks for request status in dictionary.
 *
 *  @param dict An NSDictionary with the "status" key.
 *
 *  @return Returns whether the status is SUCCESS or not.
 */
+ (BOOL)getStatusFromDict:(NSDictionary * _Nonnull)dict;

#pragma mark Date Formatting

/*!
 *  Returns a string based on the date and format provided.
 *
 *  @param date   An NSDate.
 *  @param format The date format for the string.
 *
 *  @return Returns a string from the date with the proper formatting.
 */
+ (NSString * _Nullable)stringFromDate:(NSDate * _Nonnull)date format:(NSString * _Nonnull)format;

/*!
 *  Returns a date based on the string and format provided.
 *
 *  @param string A date or dateTime string.
 *  @param format The date format for the NSDate.
 *
 *  @return Returns a date from the string with the proper formatting.
 */
+ (NSDate * _Nullable)dateFromString:(NSString * _Nonnull)string format:(NSString * _Nonnull)format;

@end
