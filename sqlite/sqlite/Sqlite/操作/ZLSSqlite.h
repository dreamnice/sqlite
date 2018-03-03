//
//  ZLSSqlite.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "item.h"

// 排序的类型
typedef enum {
    OrderByTypeUp = 1,
    OrderByTypeDown
} OrderByType;


@interface ZLSSqlite : NSObject

+ (id)defaultZLSSqlite;

- (void)CreateAllTabel:(NSArray <item *>*)itemarray;

- (BOOL)insertIntoTableWithitems:(item *)oneitem;

- (BOOL)deleteitemsInTable:(NSString *)tabalName whereDlete:(NSString *)whereDlete;

- (BOOL)updataitemsInTable:(NSString *)tabalName setString:(NSArray *)setArray whereUpdata:(NSString *)whereUpdata;

-(BOOL)checkName:(NSString *)aTableName;

- (NSArray *)queryDataFromTable:(NSString *)tableName items:(NSArray *)items whereSelected:(NSArray *)whereSelected  orderType:(OrderByType)orderType orderBy:(NSArray *)orderBy orderItemType:(NSArray *)orderItemTypes;

- (NSArray *)queryDataFromMoreTable:(NSArray *)tableName items:(NSArray *)items whereSelected:(NSArray *)whereSelected  orderType:(OrderByType)orderType orderBy:(NSArray *)orderBy orderItemType:(NSArray *)orderItemTypes;

@end
