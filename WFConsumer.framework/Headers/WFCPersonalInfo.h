//
//  PersonalInfo.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/17/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCContactInfo.h>

/*!
 *  PersonalInfo is used to store all personal information.
 */
@interface WFCPersonalInfo : NSObject

/*!
 * Contains the userName of the logged in User.
 */
@property (strong, nonatomic) NSString *consumerName;

/*!
 * 0 or 1 code depending on user gender.
 */
@property (strong, nonatomic) NSString *genderTypeCode;

/*!
 * number code depending upon user Martial Status.
 */
@property (strong, nonatomic) NSString *maritalStatusTypeCode;

/*!
 * number code depending upon user Income.
 */
@property (strong, nonatomic) NSString *incomeRangeTypeCode;

/*!
 * number code depending upon user Education.
 */
@property (strong, nonatomic) NSString *educationTypeCode;

/*!
 * Birth and Month in ddmm format.
 */
@property (strong, nonatomic) NSString *dateOfBirth;

/*!
 * number code depending upon user Age.
 */
@property (strong, nonatomic) NSString *ageRangeTypeCode;

/*!
 * ContactInfo object which will hold Contact related information.
 */
@property (strong, nonatomic) WFCContactInfo *contactInfo;

/*!
 *  Occupation tye Code is a property to describe the purpose of occupation like @"Farming"
 */
@property (strong, nonatomic) NSString *occupationTypeCode;

/*!
 * Occupation Name - if selected other option for OccupationTypeCode.
 */
@property (strong, nonatomic) NSString *occupationOther;

@end
