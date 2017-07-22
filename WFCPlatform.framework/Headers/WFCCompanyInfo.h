//
//  WFCCompanyInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 2/16/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCCompanyInfo provides a base company object for other Wells Fargo SDKs to subclass when necessary.
 */
@interface WFCCompanyInfo : NSObject

/*!
 *  Uniquely identifies a company associated with an app.
 */
@property (readonly) NSInteger companyID;

/*!
 *  The unique name of a company associated with an app.
 */
@property (strong, nonatomic) NSString * _Nonnull companyName;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCCompanyInfo instance using companyID provided.
 *
 *  @param companyID Uniquely identifies a company associated with an app.
 *
 *  @return A new initialized WFCCompanyInfo instance.
 */
- (instancetype _Nonnull)initWithCompanyID:(NSInteger)companyID;

/*!
 *  Creates and returns a WFCCompanyInfo instance using companyID, and companyName provided.
 *
 *  @param companyID   Uniquely identifies a company associated with an app.
 *  @param companyName The unique name of a company associated with an app.
 *
 *  @return A new initialized WFCCompanyInfo instance.
 */
- (instancetype _Nonnull)initWithCompanyID:(NSInteger)companyID companyName:(NSString * _Nonnull)companyName;
@end
