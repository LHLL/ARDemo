//
//  WFConsumerSDK.h
//  WFConsumerSDK
//
//  Created by Aggarwal, Vishal on 12/16/15.
//  Copyright © 2015 Wells Fargo. All rights reserved.
//

#import <WFCPlatform/WFCPlatform.h>
#import <WFConsumer/WFCConsumerInfo.h>
#import <WFConsumer/WFCMasterData.h>
#import <WFConsumer/WFCOffer.h>
#import <WFConsumer/WFCReservationProduct.h>

/*!
 *  WFConsumerManager allows access to Wells Fargo Promotions Services.
 */
@interface WFConsumerManager : WFCoreCP

/*!
 *  Completion Handler for logIn
 *
 *  @param currentConsumerInfo WFCConsumerInfo Returned
 *  @param error               Error response returned (nil if no errors).
 *  @param exception           Exception Caught
 */
typedef void (^WFCConsumerCompletion)(WFCConsumerInfo *_Nullable currentConsumerInfo, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for getting offer
 *
 *  @param offer     Offer Returned
 *  @param error     Error response returned (nil if no errors).
 *  @param exception Exception Caught
 */
typedef void (^WFCOfferCompletion)(WFCOffer *_Nullable offer, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for getting offers
 *
 *  @param offers    An array of offers returned
 *  @param error     Error response returned (nil if no errors).
 *  @param exception Exception Caught
 */
typedef void (^WFCOffersCompletion)(NSArray<WFCOffer *> *_Nullable offers, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for getting master data
 *
 *  @param data      Master data from server
 *  @param error     Error response returned (nil if no errors).
 *  @param exception Exception Caught
 */
typedef void (^WFCMasterDataHandler)(WFCMasterData *_Nullable data, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for getting loyalty info
 *
 *  @param loyaltyPoints Loyalty point
 *  @param loyaltyStatus Loyalty Status Returned
 *  @param error         Error response returned (nil if no errors).
 *  @param exception     Exception Caught
 */
typedef void (^WFCLoyaltyInfoHander)(NSInteger loyaltyPoints, NSString *_Nullable loyaltyStatus, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for validating offer
 *
 *  @param isValid    Is this offer valid or not
 *  @param error      Error response returned (nil if no errors).
 *  @param exception  Exception Caught
 */
typedef void (^WFCValideOfferCompletion)(BOOL isValid, NSArray<WFCProduct *> * _Nullable productsWithDiscount, NSString *_Nullable amountOff, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

/*!
 *  Completion Handler for redeeming offer
 *
 *  @param redemption Unique id for identifier redemption operation
 *  @param error      Error response returned
 *  @param exception  Exception Caught
 */
typedef void (^WFCReedemOfferCompletion)(NSString * _Nullable redemption, WFCErrorResponse *_Nullable error, NSException *_Nullable exception);

#pragma mark - Required Calls

/*!
 *  Set Push Device Token and sync token with server to get push notification from server
 *
 *  @param pushDeviceToken Push Device Token from Apple server
 *  @param completion      A block to execute upon completion of a request.
 */
- (void)setPushDeviceToken:(NSString * _Nonnull)pushDeviceToken
                completion:(WFCoreCPCompletionBool _Nonnull)completion;

/*!
 *  Calls the API GetMasterData to retrieve and return the initial information required for the registration process.
 *
 *  @param completion Completion Handler for getting master data
 */
-(void)getMasterDataWithCompletionWithCompletion:(WFCMasterDataHandler _Nonnull)completion;

#pragma mark - Registration and Authentication

/*!
 *  Calls the API authenticateConsumer using Username and Password to return authentication status for the user.
 *
 *  @param userName   Unique userName added by the user at the time of the registration.
 *  @param completion Completion Handler for logIn
 */
-(void)authenticateConsumerWithUserName:(NSString * _Nonnull)userName
                             completion:(WFCConsumerCompletion _Nonnull)completion;

/*!
 *  Calls the API registerAppConsumer to create a new consumer record for the provided UserName.
 *
 *  @param userDetails The userDetails object of type WFCConsumerInfo contains the consumer's information
 *  @param completion  Completion Handler for Updating Sign up
 */
-(void)signUpNewUserWithDetails:(WFCConsumerInfo * _Nonnull)userDetails
                     completion:(WFCConsumerCompletion _Nonnull)completion;

#pragma mark - User Profile

/*!
 *  Calls the API saveConsumer to Update an existing consumer record for the provided UserName with new CDM details.
 *
 *  @param userDetails The userDetails object of type WFCConsumerInfo contains the consumer's information
 *  @param completion  Completion Handler for Updating user info
 */
-(void)updateConsumerProfile:(WFCConsumerInfo * _Nonnull)userDetails
                  completion:(WFCConsumerCompletion _Nonnull)completion;

#pragma mark - Loyalty Calls

/*!
 *  Method for get loyalty point and status.
 *
 *  @param completion Completion Handler for getting offers
 */
- (void)retrieveLoyaltyInfo:(WFCLoyaltyInfoHander _Nonnull)completion;

#pragma mark - Offer Calls

/*!
 *  Calls the API to get all existing offers.
 *
 *  @param completion Completion Handler for getting offers
 */
- (void)getAllOffersWithCompletionHandler:(WFCOffersCompletion _Nonnull)completion;

/*!
 *  Calls the API to get the offer with specified offer id
 *
 *  @param offerID    Offer id retrived from getAllOffers
 *  @param completion Completion Handler for getting offer
 */
- (void)getOfferDetailsWithOfferID:(NSString * _Nonnull)offerID
                        completion:(WFCOfferCompletion _Nonnull)completion;

/*!
 *  Calls the API to redeem an existing Offer with specified offer id.
 *
 *  @param amount      original transaction amount before applying offer
 *  @param code        Unique identifier representing the consumer's offer code associated with the specific promotion
 *  @param referenceID Specifies the Unique reference ID.
 *  @param completion  A block to execute upon completion of a request.
 */
- (void)redeemOfferWithAmount:(NSString * _Nonnull)amount
                     OfferCode:(NSString * _Nonnull)code
                   ReferenceID:(NSString * _Nonnull)referenceID
                 andCompletion:(WFCReedemOfferCompletion _Nonnull)completion;

/*!
 *  Validate offer before redeem call
 *
 *  @param offerCode  Unique identifier representing the consumer's offer code associated with the specific promotion
 *  @param products   WFCProducts: products
 *  @param completion Completion Handler for validating offer
 */
- (void)validateOfferWithOfferCode:(NSString * _Nonnull)offerCode
                          Products:(NSArray<WFCReservationProduct *> * _Nonnull)products
                 CompletionHandler:(WFCValideOfferCompletion _Nonnull)completion;



@end
