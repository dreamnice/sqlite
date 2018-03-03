//
//  studentItem.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//


#import "item.h"


@interface studentItem : item

@property (assign ,readonly ,nonatomic)NSInteger sno;

@property (copy ,readonly ,nonatomic)NSString *name;

@property (copy ,readonly ,nonatomic)NSString *sex;

@property (copy ,readonly ,nonatomic)NSDate *birthday ;

@property (assign ,readonly ,nonatomic)NSInteger dno;

- (id)initWithSno:(NSInteger)sno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno;

@end
