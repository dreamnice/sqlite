//
//  studentCourse.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "item.h"

@interface studentCourseItem : item

@property (assign ,readonly ,nonatomic) NSInteger sno;

@property (assign ,readonly ,nonatomic) NSInteger cno;

@property (assign ,readonly ,nonatomic) NSInteger score;

- (id)initWithSno:(NSInteger)sno cno:(NSInteger)cno score:(NSInteger)score;

@end
