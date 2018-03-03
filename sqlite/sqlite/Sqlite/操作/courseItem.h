//
//  courseItem.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "item.h"

@interface courseItem : item

@property (assign ,readonly ,nonatomic) NSInteger cno;

@property (copy ,readonly ,nonatomic) NSString *cname;

@property (assign ,readonly ,nonatomic) NSInteger tno;

@property (assign ,readonly ,nonatomic) NSInteger credit;

@property (assign ,readonly ,nonatomic) NSInteger chour;

@property (strong ,readonly ,nonatomic) NSDate *ctime;

@property (copy ,readonly ,nonatomic) NSString *cplace;

@property (strong ,readonly ,nonatomic) NSDate *testTime;


- (id)initWithCno:(NSInteger)cno cname:(NSString *)cname tno:(NSInteger)tno credit:(NSInteger)credit chour:(NSInteger)chour ctime:(NSDate *)ctime cplace:(NSString *)cplace testTime:(NSDate *)testTime;

@end
