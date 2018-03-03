//
//  courseItem.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "courseItem.h"

@implementation courseItem

- (id)initWithCno:(NSInteger)cno cname:(NSString *)cname tno:(NSInteger)tno credit:(NSInteger)credit chour:(NSInteger)chour ctime:(NSDate *)ctime cplace:(NSString *)cplace testTime:(NSDate *)testTime{
    if([super init]){
        [self setDataWithCno:cno cname:cname tno:tno credit:credit chour:chour ctime:ctime cplace:cplace testTime:testTime];
    }
    return self;
}

- (void)setDataWithCno:(NSInteger)cno cname:(NSString *)cname tno:(NSInteger)tno credit:(NSInteger)credit chour:(NSInteger)chour ctime:(NSDate *)ctime cplace:(NSString *)cplace testTime:(NSDate *)testTime{
    _cno = cno;
    NSNumber *objectcno = [NSNumber numberWithInteger:cno];
    itemInformation *item1 = [[itemInformation alloc] initWithValue:objectcno Name:@"c_no" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ primary key",kItemTypeInteger]];
    
    _cname = cname;
    itemInformation *item2 = [[itemInformation alloc] initWithValue:cname Name:@"c_name" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _tno = tno;
    NSNumber *objecttno = [NSNumber numberWithInteger:tno];
    itemInformation *item3 = [[itemInformation alloc] initWithValue:objecttno Name:@"t_no" ValueType:kItemTypeInteger headvalueType:kItemTypeInteger];
    
    _credit = credit;
    NSNumber *objectcedit = [NSNumber numberWithInteger:credit];
    itemInformation *item4 = [[itemInformation alloc] initWithValue:objectcedit Name:@"credit" ValueType:kItemTypeInteger headvalueType:kItemTypeInteger];
    
    _chour = chour;
    NSNumber *objectchour = [NSNumber numberWithInteger:chour];
    itemInformation *item5 = [[itemInformation alloc] initWithValue:objectchour Name:@"c_hour" ValueType:kItemTypeInteger headvalueType:kItemTypeInteger];
    
    _ctime = ctime;
    NSNumber *objectCtime = [NSNumber numberWithDouble:[ctime timeIntervalSince1970]];
    itemInformation *item6 = [[itemInformation alloc] initWithValue:objectCtime Name:@"c_time" ValueType:kItemTypeDouble headvalueType:kItemTypeDouble];
    
    _cplace = cplace;
    itemInformation *item7 = [[itemInformation alloc] initWithValue:cplace Name:@"c_place" ValueType:kItemTypeText headvalueType:kItemTypeText];
    
    _testTime = testTime;
    NSNumber *objecttestTime = [NSNumber numberWithDouble:[testTime timeIntervalSince1970]];
    itemInformation *item8 = [[itemInformation alloc] initWithValue:objecttestTime Name:@"c_testtime" ValueType:kItemTypeDouble headvalueType:kItemTypeDouble];

    
    self.itemTableName = @"course_5470";
    NSArray <itemInformation *>*infomationItem = @[item1,item2,item3,item4,item5,item6,item7,item8];
    self.informations = [infomationItem copy];
}


@end
