//
//  personalData.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "personalData.h"

@implementation personalData

// 用来保存唯一的单例对象
static id _instace;

static dispatch_once_t onceToken;

+ (id)allocWithZone:(struct _NSZone *)zone
{
    
    dispatch_once(&onceToken, ^{   //onceToken是GCD用来记录是否执行过 ，如果已经执行过就不再执行(保证执行一次）
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}


+ (instancetype)sharedData
{
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instace;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    return _instace;
}

- (void)setDataWithSno:(NSInteger)sno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday  dno:(NSString *)dno{
    _sno = sno;
    _name = name;
    _sex = sex;
    _birthday = birthday;
    _dno = dno;
}

//销毁单例
+ (void)destroyInstance {
    onceToken = 0;
    _instace=nil;
}


- (void)dealloc{
    NSLog(@"单例已销毁");
}

@end
