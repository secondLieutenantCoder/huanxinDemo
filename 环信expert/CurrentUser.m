//
//  CurrentUser.m
//  环信expert
//
//  Created by INTCO 王伟 on 2017/1/13.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import "CurrentUser.h"

CurrentUser * user;
@implementation CurrentUser


+(CurrentUser *) defaultUser;{

    return user;
}
+ (instancetype)initWithName:(NSString *)name{

    if (user ==nil) {
        user = [[CurrentUser alloc] init];
        user.userName  = name;
    }
    
    return user;
}

@end
