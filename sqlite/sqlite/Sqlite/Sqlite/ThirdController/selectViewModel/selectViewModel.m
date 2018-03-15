//
//  selectViewModel.m
//  sqlite
//
//  Created by 朱力珅 on 2018/3/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "selectViewModel.h"
#import "subjectData.h"
#import "ZLSSqlite.h"
#import "personalData.h"

@implementation selectViewModel

- (void)fetchSelectData:(ReturnBlock)returnBlock{
    NSMutableArray <subjectData *>*subjecArray = [NSMutableArray array];
    NSArray *tablename = @[@"course_5470",@"student_course_5470"];
    NSString *str = [NSString stringWithFormat:@"%ld",[personalData sharedData].sno];
    NSArray *array = [[[ZLSSqlite defaultZLSSqlite] queryDataFromMoreTable:tablename items:@[@"course_5470.c_no",@"course_5470.c_name",@"course_5470.t_no",@"course_5470.credit",@"course_5470.c_hour",@"course_5470.c_time",@"course_5470.c_place",@"course_5470.c_testtime"] whereSelected:@[[NSString stringWithFormat:@"student_course_5470.s_no = %@",str], @"student_course_5470.c_no = course_5470.c_no"] orderType:OrderByTypeUp orderBy:@[@"course_5470.c_no"] orderItemType:@[kItemTypeInteger,kItemTypeText,kItemTypeInteger,kItemTypeInteger,kItemTypeInteger,kItemTypeDouble,kItemTypeText,kItemTypeDouble]] mutableCopy];
    NSLog(@"%@",array);
    for(NSDictionary *dic in array){
        subjectData *data = [[subjectData alloc] initWithCno:[dic[@"course_5470.c_no"] integerValue] cname:dic[@"course_5470.c_name"] tno:[dic[@"course_5470.t_no"] integerValue] credit:[dic[@"course_5470.credit"] integerValue] chour:[dic[@"course_5470.c_hour"] integerValue] ctime:[NSDate dateWithTimeIntervalSince1970:[dic[@"course_5470.c_time"] doubleValue]] cplace:dic[@"course_5470.c_place"] testTime:[NSDate dateWithTimeIntervalSince1970:[dic[@"course_5470.c_testtime"] doubleValue]]];
        [subjecArray addObject:data];
    }
    returnBlock(subjecArray);
}

@end
