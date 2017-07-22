//
//  WFCFacilityInfo.h
//  WFCPlatform
//
//  Created by Williams, Tabari D. on 2/16/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>

/*!
 *  WFCFacilityInfo provides a base facility object for other Wells Fargo SDKs to subclass when necessary.
 */
@interface WFCFacilityInfo : NSObject

/*!
 *  Uniquely identifies a facility associated with a company.
 */
@property (readonly) NSInteger facilityID;

/*!
 *  The unique name of a facility associated with a company.
 */
@property (strong, nonatomic) NSString * _Nonnull facilityName;

- (instancetype _Nonnull)init NS_UNAVAILABLE;

/*!
 *  Creates and returns a WFCFacilityInfo instance using facilityID provided.
 *
 *  @param facilityID Uniquely identifies a facility associated with a company.
 *
 *  @return A new initialized WFCFacilityInfo instance.
 */
- (instancetype _Nonnull)initWithFacilityID:(NSInteger)facilityID;

/*!
 *  Creates and returns a WFCFacilityInfo instance using facilityID, and facilityName provided.
 *
 *  @param facilityID   Uniquely identifies a facility associated with a company.
 *  @param facilityName The unique name of a facility associated with a company.
 *
 *  @return A new initialized WFCFacilityInfo instance.
 */
- (instancetype _Nonnull)initWithFacilityID:(NSInteger)facilityID facilityName:(NSString * _Nonnull)facilityName;
@end
