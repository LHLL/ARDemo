//
//  Ambassador.h
//  NSC
//
//  Created by Xu, Jay on 12/14/16.
//  Copyright © 2016 Jay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AmbassadorStatus) {
    unfound,
    found,
    openToFind
};

@interface Ambassador : NSObject

@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) NSInteger id;
@property (strong, nonatomic) NSUUID *identifier;
@property (strong, nonatomic) NSString *tag;
@property (assign, nonatomic) AmbassadorStatus stat;
@property (assign, nonatomic) NSInteger major;
@property (assign, nonatomic) NSInteger minor;
@property (assign, nonatomic) BOOL collected;
@property (assign, nonatomic) BOOL showed;

@end
