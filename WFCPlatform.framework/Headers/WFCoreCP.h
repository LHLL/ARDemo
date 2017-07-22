//
//  WFCoreCP.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 12/15/15.
//  Copyright © 2015 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCoreCompletion.h>
#import <WFCPlatform/WFCWebServiceHandler.h>
#import <WFCPlatform/WFCFacilityInfo.h>
#import <WFCPlatform/WFCEventTriggerInfo.h>

/*!
 *  WFCoreCP provides the core functionality for any SDK to access and provide information to a Wells Fargo Service.
 */
@interface WFCoreCP : NSObject

/*!
 *  Uniquely identifies the mobile application within Wells Fargo Services. Set when the WFCoreCP object is initialized.
 */
@property (readonly) NSString * _Nonnull appID;

/*!
 *  A secret shared key between mobile application and Wells Fargo Services. Set when the WFCoreCP object is initialized.
 */
@property (readonly) NSString * _Nonnull appKey;

/*!
 *  Uniquely identifies a company associated with an app. Set when the WFCoreCP object is initialized.
 */
@property (readonly) WFCCompanyInfo * _Nonnull companyInfo;

/*!
 *  Uniquely identifies a facility associated with an app's company.
 */
@property (strong, nonatomic) WFCFacilityInfo * _Nullable facilityInfo;

/*!
 *  Uniquely identifies a consumer of the app. Set when the WFCoreCP object is initialized.
 */
@property (readonly) NSString * _Nonnull consumerID;

/*!
 *  Handles all of the web service calls to Wells Fargo Services for the WFCoreCP object. Set when the WFCoreCP object is initialized.
 */
@property (readonly) WFCWebServiceHandler * _Nonnull webServiceHandler;

/*!
 *  Uniquely identifies a Service's user.
 */
@property (strong, nonatomic) NSString * _Nonnull userToken;

/*!
 *  The token given when an app successfully registers for remote notifications. If the messaging services are to be triggered, pushDeviceToken cannot be nil.
 */
@property (strong, nonatomic) NSString * _Nonnull pushDeviceToken;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCoreCP instance using the appID, appKey, companyID, consumerID, and mode provided.
 *
 *  @param appID       Uniquely identifies the mobile application within Wells Fargo Services. Set when the WFCoreCP object is initialized.
 *  @param appKey      A secret shared key between mobile application and Wells Fargo Services. Set when the WFCoreCP object is initialized.
 *  @param companyInfo Uniquely identifies a company associated with an app. Set when the WFCoreCP object is initialized.
 *  @param consumerID  Uniquely identifies a consumer of the app. Set when the WFCoreCP object is initialized.
 *  @param environment Sets which environment the WFCoreCP instance will use.
 *  @param completion  The block to execute after the WFCoreCP object is initialized. Takes a BOOL as a parameter to indicate if the instance was initialized successfully.  Takes an NSArray as a parameter to indicate if any initialization errors occured. Takes an NSException as a parameter to indicate if any exceptions were caught.
 *
 *  @return A new initialized WFCoreCP instance.
 */
- (instancetype _Nonnull)initWithAppID:(NSString * _Nonnull)appID
                                appKey:(NSString * _Nonnull)appKey
                           companyInfo:(WFCCompanyInfo * _Nonnull)companyInfo
                            consumerID:(NSString * _Nonnull)consumerID
                           environment:(WFCoreCPEnvironment)environment
                            completion:(WFCoreCPCompletionBool _Nonnull)completion;

/*!
 *  Allows an app to set a new value for a consumerID.
 *
 *  @param consumerID Uniquely identifies a consumer of the app.    
 *  @param completion The block to execute after the consumerID is set. Takes a BOOL as a parameter to indicate if the consumerID was set successfully.  Takes an NSArray as a parameter to indicate if any errors occured. Takes an NSException as a parameter to indicate if any exceptions were caught.
 */
- (void)setConsumerID:(NSString * _Nonnull)consumerID
           completion:(WFCoreCPCompletionBool _Nonnull)completion;

/*!
 *  Submits an event to trigger rules.
 *
 *  @param eventInfo  The metadata of the event
 *  @param completion The block to execute after the event is submitted. Takes a BOOL as a parameter to indicate if the event was submitted successfully.  Takes an NSArray as a parameter to indicate if any errors occured. Takes an NSException as a parameter to indicate if any exceptions were caught.
 */
- (void)submitEventWithInfo:(WFCEventTriggerInfo * _Nonnull)eventInfo
                 completion:(WFCoreCPCompletionBool _Nonnull)completion;

@end