//
//  departmentItem.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "departmentItem.h"

@implementation departmentItem

- (id)initWithDno:(NSInteger)dno dname:(NSString *)dname{
    if([super init]){
        [self setDno:dno dname:dname];
    }
    return self;
}

- (void)setDno:(NSInteger)dno dname:(NSString *)dname{
    _dno = dno;
    NSNumber *objectdno = [NSNumber numberWithInteger:dno];
    itemInformation *item1 = [[itemInformation alloc] initWithValue:objectdno Name:@"d_no" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ primary key",kItemTypeInteger]];
    
    _dname = dname;
    itemInformation *item2 = [[itemInformation alloc] initWithValue:dname Name:@"d_name" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    self.itemTableName = @"department_5470";
    NSArray <itemInformation *>*infomationItem = @[item1,item2];
    self.informations = [infomationItem copy];
}

@end
