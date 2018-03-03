//
//  item.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "itemInformation.h"

static  NSString *kItemTypeText = @"TEXT";
static  NSString *kItemTypeInteger = @"INTEGER";
static  NSString *kItemTypeBool = @"BOOL";
static  NSString *kItemTypeDouble = @"DOUBLE";


@interface item : NSObject

@property (copy ,nonatomic) NSString *itemTableName;

@property (copy ,nonatomic) NSArray  <itemInformation *>*informations;

@end
