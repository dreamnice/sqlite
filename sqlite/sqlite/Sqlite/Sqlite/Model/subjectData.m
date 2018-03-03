//
//  subjectData.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "subjectData.h"

@implementation subjectData

- (id)initWithCno:(NSInteger)cno cname:(NSString *)cname tno:(NSInteger)tno credit:(NSInteger)credit chour:(NSInteger)chour ctime:(NSDate *)ctime cplace:(NSString *)cplace testTime:(NSDate *)testTime{
    if([super init]){
        [self setDataWithCno:cno cname:cname tno:tno credit:credit chour:chour ctime:ctime cplace:cplace testTime:testTime];
    }
    return self;
}

- (void)setDataWithCno:(NSInteger)cno cname:(NSString *)cname tno:(NSInteger)tno credit:(NSInteger)credit chour:(NSInteger)chour ctime:(NSDate *)ctime cplace:(NSString *)cplace testTime:(NSDate *)testTime{
    _cno = cno;
    _cname = cname;
    _tno = tno;
    _credit = credit;
    _chour = chour;
    _ctime = ctime;
    _cplace = cplace;
    _testTime = testTime;
}



@end
