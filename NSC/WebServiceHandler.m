//
//  WebServiceHandler.m
//  NSC
//
//  Created by Xu, Jay on 12/20/16.
//  Copyright © 2016 Jay. All rights reserved.
//

#import "WebServiceHandler.h"
#import <WFConsumer/WFConsumer.h>
#import <WFCPlatform/WFCPlatform.h>
@interface WebServiceHandler()

@property (strong, nonatomic) WFConsumerManager *manager;

@end

@implementation WebServiceHandler

- (void)checkUiquenessWithUserName:(NSString *)userName and:(WebServiceCompletion)completion {
    WFCCompanyInfo *companyInfo = [[WFCCompanyInfo alloc]initWithCompanyID:5072];
    self.manager = [[WFConsumerManager alloc] initWithAppID:@"nsc2017"
                                                     appKey:@"nsc2017"
                                                companyInfo:companyInfo
                                                 consumerID:@"0"
                                                environment:WFCoreCPEnvironmentPCEUAT
                                                 completion:^(BOOL success,
                                                              WFCErrorResponse *error,
                                                              NSException *exception) {
                        if (success) {
                            [self authenticateUser:userName and:completion];
                        }else if (error) {
                            completion(NO,error.errorDetails[0].errorMessage);
                        }else if (exception) {
                            completion(NO,exception.reason);
                        }
                    }];
}

- (void)startRegisteringUserWith:(NSString *)name
                                :(NSString *)email
                                :(WebServiceCompletion)completion {
    
    [self registerProcessWith:name
                             :email
                             :^(BOOL success,
                                NSString *error) {
                                 completion(success, error);
                             }];
}

- (void) registerProcessWith:(NSString *)name
                            :(NSString *)email
                            :(WebServiceCompletion)completion {
    
    //All following fields are mandatory for V2 API
    WFCConsumerInfo *user = [[WFCConsumerInfo alloc]init];
    user.personalInfo.contactInfo.addressInfo.addressId = @"";
    user.personalInfo.contactInfo.phoneInfo.number = @"";
    user.personalInfo.maritalStatusTypeCode = @"1";
    user.merchantTypes = [[NSMutableArray alloc]initWithArray:@[@1,@2]];
    user.preference.preferEmailFlag = @"1";
    user.preference.preferSmsFlag = @"1";
    user.preference.preferAppFlag = @"1";
    user.consumerGroupCodes = [[NSMutableArray alloc]initWithArray:@[@3,@4]];
    user.personalInfo.incomeRangeTypeCode = @"1";
    user.personalInfo.ageRangeTypeCode = @"1";
    user.accountStatusCode = @"1";
    user.consumerTypeCode = @"1";
    user.personalInfo.educationTypeCode = @"1";
    user.personalInfo.dateOfBirth = @"0307";
    user.personalInfo.occupationTypeCode = @"1";
    user.personalInfo.occupationOther = @"farming";
    user.personalInfo.genderTypeCode = @"1";
    user.personalInfo.consumerName = email;
    user.firstName = name;
    user.middleName = @"";
    user.lastName = name;
    user.preference.preferenceTypeCode = 1;
    user.suffix = @"";
    user.personalInfo.contactInfo.contactTypeCode = @"1";
    user.personalInfo.contactInfo.emailInfo.address = email;
    user.personalInfo.contactInfo.emailInfo.confirmedEmail = YES;
    user.personalInfo.contactInfo.emailInfo.addressTypeCode = @"1";
    user.personalInfo.contactInfo.phoneInfo.number = @"6666666666";
    user.personalInfo.contactInfo.phoneInfo.confirmedPhone = YES;
    user.personalInfo.contactInfo.phoneInfo.phoneTypeCode = @"1";
    user.personalInfo.contactInfo.addressInfo.line1 = @"333 Market Street";
    user.personalInfo.contactInfo.addressInfo.line2 = @"";
    user.personalInfo.contactInfo.addressInfo.line3 = @"";
    user.personalInfo.contactInfo.addressInfo.addressId = @"";
    user.personalInfo.contactInfo.addressInfo.city = @"SFO";
    user.personalInfo.contactInfo.addressInfo.postalCode = @"123456";
    user.personalInfo.contactInfo.addressInfo.stateCode = @"CA";
    user.personalInfo.contactInfo.addressInfo.countryCode = @"US";
    user.personalInfo.contactInfo.addressInfo.addressTypeCode = @"1";
    user.loyaltyDetails.pointType = WFCLoyaltyPointTypeBalance;
    user.personalInfo.contactInfo.contactId = @"";
    
    [self.manager signUpNewUserWithDetails:user completion:^(WFCConsumerInfo *currentConsumerInfo,
                                                             WFCErrorResponse *error,
                                                             NSException *exception) {
        
        if(error){
            completion (YES,nil);
        }else if (exception) {
            completion (NO,exception.reason);
        }else {
            completion (YES,nil);
        }
    }];
}

- (void)authenticateUser:(NSString *)userName and:(WebServiceCompletion)completion {
    //When Register a user, we always use email address as user name, so we can check user name to identifier duplicate user
    [self.manager authenticateConsumerWithUserName:userName
                                        completion:^(WFCConsumerInfo *currentConsumerInfo,
                                                     WFCErrorResponse *error,
                                                     NSException *exception) {
        if (!currentConsumerInfo) {
            completion (YES, nil);
        }else if (error){
            completion (NO,error.errorDetails[0].errorMessage);
        }else if (exception) {
            completion (NO,exception.reason);
        }else {
            completion(NO,nil);
        }
    }];
}

+(WebServiceHandler *)defaultManager {
    static dispatch_once_t onceToken;
    static WebServiceHandler *handler;
    dispatch_once(&onceToken, ^{
        if (!handler) {
            handler = [[WebServiceHandler alloc]init];
        }
    });
    return handler;
}

@end
