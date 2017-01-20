//
//  CurrentUser.h
//  环信expert
//
//  Created by INTCO 王伟 on 2017/1/13.
//  Copyright © 2017年 INTCO 王伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrentUser : NSObject


@property (nonatomic,copy) NSString * userName;

+(instancetype) defaultUser;

+ (instancetype)initWithName:(NSString *)name;
@end
