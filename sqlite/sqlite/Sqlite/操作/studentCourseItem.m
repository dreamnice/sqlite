//
//  studentCourse.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "studentCourseItem.h"

@implementation studentCourseItem

- (id)initWithSno:(NSInteger)sno cno:(NSInteger)cno score:(NSInteger)score{
    if([super init]){
        [self setDataWithSno:sno cno:cno score:score];
    }
    return self;
}

- (void)setDataWithSno:(NSInteger)sno cno:(NSInteger)cno score:(NSInteger)score{
    _sno = sno;
    NSNumber *objecctsno = [NSNumber numberWithInteger:sno];
    itemInformation *item1 = [[itemInformation alloc] initWithValue:objecctsno Name:@"s_no" ValueType:kItemTypeInteger headvalueType:kItemTypeInteger];
    
    _cno = cno;
    NSNumber *objecctcno = [NSNumber numberWithInteger:cno];
    itemInformation *item2 = [[itemInformation alloc] initWithValue:objecctcno Name:@"c_no" ValueType:kItemTypeInteger headvalueType:kItemTypeInteger];
    
    _score = score;
    NSNumber *objectEnterScore = [NSNumber numberWithInteger:score];
    itemInformation *item3 = [[itemInformation alloc] initWithValue:objectEnterScore Name:@"s_score" ValueType:kItemTypeInteger headvalueType:[NSString stringWithFormat:@"%@ , foreign key (c_no) references course_5470(c_no) on delete cascade,primary key (s_no,c_no)",kItemTypeInteger]];
    
    self.itemTableName = @"student_course_5470";
    NSArray <itemInformation *>*infomationItem = @[item1,item2,item3];
    self.informations = [infomationItem copy];
}


@end
