//
//  WebServiceHandler.h
//  NSC
//
//  Created by Xu, Jay on 12/20/16.
//  Copyright © 2016 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>

//This class is built in Objective-C is because of CP V2 APIs have some problems handling swift requests. Can be removed or modified to swift class if v3 APIs supports swift well
typedef void (^WebServiceCompletion)(BOOL success, NSString *error);

@interface WebServiceHandler : NSObject

- (void)startRegisteringUserWith:(NSString *)name
                                :(NSString *)email
                                :(WebServiceCompletion)completion;

- (void)checkUiquenessWithUserName:(NSString *)userName
                               and:(WebServiceCompletion)completion;

+(WebServiceHandler *)defaultManager;

@end
