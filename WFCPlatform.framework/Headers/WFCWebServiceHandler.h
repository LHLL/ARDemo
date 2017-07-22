//
//  WFCWebServiceHandler.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 12/15/15.
//  Copyright © 2015 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFCPlatform/WFCoreCompletion.h>
#import <WFCPlatform/WFCCompanyInfo.h>
#import <WFCPlatform/WFCResponse.h>
#import <WFCPlatform/WFCResponseBody.h>

/*!
 *  The available modes of the WFCWebServiceHandler.
 */
typedef NS_ENUM(NSInteger, WFCoreCPEnvironment) {
    /*!
     *  Simulate allows the sdk to provide a set response for testing purposes.
     */
    WFCoreCPEnvironmentSimulate,
    /*!
     *  PCE Dev environment.
     */
    WFCoreCPEnvironmentPCEDev,
    /*!
     *  PCE UAT environment.
     */
    WFCoreCPEnvironmentPCEUAT,
    /*!
     *  PCE Prod environment.
     */
    WFCoreCPEnvironmentPCEProd,
    /*!
     *  Reservation Lower Lab environment.
     */
    WFCoreCPEnvironmentReservationLower,
    /*!
     *  Lower Lab environment.
     */
    WFCoreCPEnvironmentLower,
    /*!
     *  Upper Lab environment.
     */
    WFCoreCPEnvironmentUpper,
    /*!
     *  UAT environment.
     */
    WFCoreCPEnvironmentUAT,
    /*!
     *  Production environment.
     */
    WFCoreCPEnvironmentProd
};

/*!
 *  The available web request types.
 */
typedef NS_ENUM(NSInteger, WFCWebServiceHTTPMethod) {
    /*!
     *  GET Request
     */
    WFCWebServiceHTTPMethodGET,
    /*!
     *  POST Request
     */
    WFCWebServiceHTTPMethodPOST
};

/*!
 *  WFCWebServiceHandler allows an sdk to make calls to Wells Fargo Services.
 */
@interface WFCWebServiceHandler : NSObject

/*!
 *  A block to execute upon completion of a request.
 *
 *  @param response The response returned from the request.
 */
typedef void (^WFCWebServiceCompletion)(id _Nullable response);

/*!
 *  Uniquely identifies a device.
 */
@property (readonly) NSString * _Nonnull deviceToken;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCWebServiceHandler instance using appID, appKey, and mode provided.
 *
 *  @param appID       Uniquely identifies the mobile application within Wells Fargo Services. Set when the WFCoreCP object is initialized.
 *  @param appKey      A secret shared key between mobile application and Wells Fargo Services. Set when the WFCoreCP object is initialized.
 *  @param companyInfo Uniquely identifies a company associated with an app. Set when the WFCoreCP object is initialized.
 *  @param consumerID  Uniquely identifies a consumer of the app. Set when the WFCoreCP object is initialized.
 *  @param environment Sets which environment the WFCWebServiceHandler instance will use.
 *  @param completion  The block to execute after the WFCWebServiceHandler object is initialized. Takes a BOOL as a parameter to indicate if the instance was initialized successfully.  Takes an NSArray as a parameter to indicate if any errors occured. Takes an NSException as a parameter to indicate if any exceptions were caught.
 *
 *  @return A new initialized WFCWebServiceHandler instance.
 */
- (instancetype _Nonnull)initWithAppID:(NSString * _Nonnull)appID
                                appKey:(NSString * _Nonnull)appKey
                           companyInfo:(WFCCompanyInfo * _Nonnull)companyInfo
                            consumerID:(NSString * _Nonnull)consumerID
                           environment:(WFCoreCPEnvironment)environment
                            completion:(WFCoreCPCompletionBool _Nonnull)completion;

/*!
 *  Makes a request to Wells Fargo Services.
 *
 *  @param path               The request path.
 *  @param httpMethod         Allows selection of a GET or POST request.
 *  @param contextMessageType The context message type.
 *  @param headers            Additional headers for the request.
 *  @param body               The body of the request if POST.
 *  @param responseType       The response type of the API response.
 *  @param simulateFilePath   The file path of simulated data to be returned in simulate mode.
 *  @param completion         The block to execute after a response is returned from Wells Fargo Service. Takes a WFCResponseBody object as a parameter.
 *  @code  [self.webServiceHandler requestWithPath:@"path"
                               httpMethod:WFCWebServiceHTTPMethodPOST
                       contextMessageType:@"messageType"
                   headers:@{@"headerKey":@"headerValue"}
                                     body:body
                             responseType:@"responseType"
                         simulateFilePath:@"filePath"
                               completion:^(id _Nullable response) {
 
                               }];
 */
- (void)requestWithPath:(NSString * _Nonnull)path
             httpMethod:(WFCWebServiceHTTPMethod)httpMethod
     contextMessageType:(NSString * _Nonnull)contextMessageType
                headers:(NSDictionary<NSString *, NSString *> * _Nullable)headers
                   body:(NSDictionary * _Nullable)body
           responseType:(NSString * _Nullable)responseType
       simulateFilePath:(NSString * _Nonnull)simulateFilePath
             completion:(WFCWebServiceCompletion _Nonnull)completion;

@end
