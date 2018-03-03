//
//  teacherItem.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "item.h"

@interface teacherItem : item

@property (assign ,readonly ,nonatomic)NSInteger tno;

@property (copy ,readonly ,nonatomic)NSString *name;

@property (copy ,readonly ,nonatomic)NSString *sex;

@property (copy ,readonly ,nonatomic)NSDate *birthday ;

@property (assign ,readonly ,nonatomic)NSInteger dno;

- (id)initWithTno:(NSInteger)tno name:(NSString *)name sex:(NSString *)sex birthday:(NSDate *)birthday dno:(NSInteger)dno;


@end
