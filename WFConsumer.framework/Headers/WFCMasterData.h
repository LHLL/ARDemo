//
//  MasterData.h
//  WFConsumer
//
//  Created by Xu, Jay on 5/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WFConsumer/WFCMasterType.h>
#import <WFConsumer/WFCCountry.h>
#import <WFConsumer/WFCState.h>

/*!
 *  Master data
 */
@interface WFCMasterData : NSObject

/*!
 *  An arry of age range type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *ageRangeTypes;

/*!
 *  An arry of gender range type
 */
@property (strong, nonatomic) NSArray<WFCMasterType *> *genderTypes;

/*!
 *  An arry of marital status type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *maritalStatusTypes;

/*!
 *  An arry of income range type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *incomeRangeTypes;

/*!
 *  An arry of consumer group type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *consumerGroupTypes;

/*!
 *  An arry of education type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *educationTypes;

/*!
 *  An arry of state
 */
@property (strong, nonatomic) NSMutableArray<WFCState *> *states;

/*!
 *  An arry of occuption type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *occupationTypes;

/*!
 *  An arry of country
 */
@property (strong, nonatomic) NSMutableArray<WFCCountry *> *country;

/*!
 *  An arry of merchant type
 */
@property (strong, nonatomic) NSMutableArray<WFCMasterType *> *merchantTypes;

/*!
 *  Default init method
 *
 *  @param responseBody NSDictionary converted from Json file from backend server
 *
 *  @return An instance of WFCMasterData class
 */
- (instancetype)initWithResponse:(NSDictionary *)responseBody;
@end
