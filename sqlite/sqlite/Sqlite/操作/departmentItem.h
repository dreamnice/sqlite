//
//  departmentItem.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "item.h"

@interface departmentItem : item

@property (assign ,readonly ,nonatomic)NSInteger dno;

@property (copy ,readonly ,nonatomic)NSString *dname;

- (id)initWithDno:(NSInteger)dno dname:(NSString *)dname;

@end
