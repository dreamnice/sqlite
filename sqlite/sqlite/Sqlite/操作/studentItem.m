//
//  studentItem.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

//学号、姓名、性别、出生日期、入学成绩、所在系号。

#import "studentItem.h"

@implementation studentItem

- (id)initWithSno:(NSInteger)sno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno{
    if([super init]){
        [self setDataWithSno:sno name:name sex:sex birthday:birthday dno:dno];
    }
    return self;
}

- (void)setDataWithSno:(NSInteger)sno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno{
    _sno = sno;
    NSNumber  *objectsno = [NSNumber numberWithInteger:sno];
    itemInformation *item1 = [[itemInformation alloc] initWithValue:objectsno Name:@"s_no" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ primary key",kItemTypeInteger]];
    
    _name = name;
    itemInformation *item2 = [[itemInformation alloc] initWithValue:name Name:@"s_name" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _sex = sex;
    itemInformation *item3 = [[itemInformation alloc] initWithValue:sex Name:@"s_sex" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _birthday = birthday;
    NSTimeInterval birthdaydouble = [birthday timeIntervalSince1970];
    NSNumber *objectbirthday = [NSNumber numberWithDouble:birthdaydouble];
    itemInformation *item4 = [[itemInformation alloc] initWithValue:objectbirthday Name:@"s_birthday" ValueType:kItemTypeDouble headvalueType:kItemTypeDouble];
    
    _dno = dno;
    NSNumber  *objectdno = [NSNumber numberWithInteger:dno];
    itemInformation *item5 = [[itemInformation alloc] initWithValue:objectdno Name:@"s_dno" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ , FOREIGN KEY(s_dno) REFERENCES department_5470(dno)",kItemTypeInteger]];
    self.itemTableName = @"student_5470";
    NSArray <itemInformation *>*infomationItem = @[item1,item2,item3,item4,item5];
    self.informations = [infomationItem copy];
}



@end
