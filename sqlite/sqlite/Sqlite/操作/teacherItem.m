//
//  teacherItem.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "teacherItem.h"

@implementation teacherItem

- (id)initWithTno:(NSInteger)tno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno{
    if([super init]){
        [self setDataWithTno:tno name:name sex:sex birthday:birthday dno:dno];
    }
    return self;
}

- (void)setDataWithTno:(NSInteger)tno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno{
    _tno = tno;
    NSNumber  *objectsno = [NSNumber numberWithInteger:tno];
    itemInformation *item1 = [[itemInformation alloc] initWithValue:objectsno Name:@"t_no" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ primary key",kItemTypeInteger]];
    
    _name = name;
    itemInformation *item2 = [[itemInformation alloc] initWithValue:name Name:@"t_name" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _sex = sex;
    itemInformation *item3 = [[itemInformation alloc] initWithValue:sex Name:@"t_sex" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _birthday = birthday;
    NSTimeInterval birthdaydouble = [birthday timeIntervalSince1970];
    NSNumber *objectbirthday = [NSNumber numberWithDouble:birthdaydouble];
    itemInformation *item4 = [[itemInformation alloc] initWithValue:objectbirthday Name:@"t_birthday" ValueType:kItemTypeDouble headvalueType:kItemTypeDouble];
    
    _dno = dno;
    NSNumber  *objectdno = [NSNumber numberWithInteger:dno];
    itemInformation *item5 = [[itemInformation alloc] initWithValue:objectdno Name:@"t_dno" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ , FOREIGN KEY(t_dno) REFERENCES department_5470(dno)",kItemTypeInteger]];
    
    self.itemTableName = @"teacher_5470";
    NSArray <itemInformation *>*infomationItem = @[item1,item2,item3,item4,item5];
    self.informations = [infomationItem copy];
}

@end
