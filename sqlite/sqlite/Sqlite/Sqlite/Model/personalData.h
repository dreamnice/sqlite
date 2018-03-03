//
//  personalData.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface personalData : NSObject

@property (assign ,readonly ,nonatomic)NSInteger sno;

@property (copy ,readonly ,nonatomic)NSString *name;

@property (copy ,readonly ,nonatomic)NSString *sex;

@property (copy ,readonly ,nonatomic)NSDate *birthday ;

@property (copy ,readonly ,nonatomic)NSString *dno;

@property (assign ,nonatomic) BOOL isTeacher;;

- (void)setDataWithSno:(NSInteger)sno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSString *)dno;

+ (instancetype)sharedData;

@end
