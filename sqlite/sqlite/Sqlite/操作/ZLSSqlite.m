//
//  ZLSSqlite.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "ZLSSqlite.h"
#import <sqlite3.h>



@interface ZLSSqlite (){
    sqlite3 *database;
}

@property (copy, nonatomic) NSString *dataBasePath;

@end

@implementation ZLSSqlite

static ZLSSqlite *_sqliteHelper;
static NSString *dbFullPath;




+ (id)defaultZLSSqlite{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sqliteHelper = [[ZLSSqlite alloc] init];
    });
    return _sqliteHelper;
}

- (BOOL)openDB{
    int t = sqlite3_open([self.dataBasePath UTF8String], &database);
    if(t == SQLITE_OK){
        return YES;
    }else{
        return NO;
    }
}

- (void)CreateAllTabel:(NSArray <item *>*)itemarray{
    if([self openDB]){
        for(item *oneitem in itemarray){
            if(![self checkName:oneitem.itemTableName]){
                [self createTableItems:oneitem];
            }
        }
    }
     sqlite3_close(database);
}

//创建表
- (BOOL)createTableItems:(item *)items{
    if([self openDB]){
        NSString *t;
        if([items.itemTableName isEqualToString:@""]  && items == nil && items.informations.count == 0){
            NSLog(@"请输入适当参数");
            return NO;
        }else{
            NSString *createTableSqlStr = [NSString stringWithFormat:@"CREATE TABLE %@ (",items.itemTableName];
            for(itemInformation *item in items.informations){
                NSString *itemStr = [NSString stringWithFormat:@"%@ %@ ,",item.name,item.heandvalueType];
                createTableSqlStr = [createTableSqlStr stringByAppendingString:itemStr];
            }
            createTableSqlStr = [createTableSqlStr substringWithRange: NSMakeRange(0, createTableSqlStr.length - 1)];
            createTableSqlStr = [createTableSqlStr stringByAppendingString:@")"];
            NSLog(@"%@",createTableSqlStr);
            char *erroMsg = NULL;
            int result = sqlite3_exec(database, [createTableSqlStr UTF8String], NULL, NULL, &erroMsg);
            if (result == SQLITE_OK) {
                NSLog(@"成功创表");
                return YES;
            } else {
                NSLog(@"创表失败--%s", erroMsg);
                sqlite3_close(database);
                return NO;
            }
       
        }
    }else{
        NSLog(@"数据库连接失败");
        return NO;
    }
}

//插入表
- (BOOL)insertIntoTableWithitems:(item *)oneitem{
    if([self openDB]){
        if(oneitem.itemTableName == 0){
            NSLog(@"请输入适当的参数");
            return NO;
        }else{
            if(![self checkName:oneitem.itemTableName]){
                if(![self createTableItems:oneitem]){
                    NSLog(@"创表失败");
                    return NO;
                }
            }
            // 插入数据的sql语句
            NSString *insertStr = [NSString stringWithFormat:@"INSERT INTO  %@ (",oneitem.itemTableName];
            NSString *valuesFlag = @"(";
            for (itemInformation *aitem in oneitem.informations) {
                NSString *item = [NSString stringWithFormat:@"%@,",aitem.name];
                valuesFlag = [valuesFlag stringByAppendingString: @"?,"];
                insertStr = [insertStr stringByAppendingString:item];
            }
            insertStr = [insertStr substringWithRange:NSMakeRange(0, insertStr.length - 1)];
            insertStr = [insertStr stringByAppendingString:@") values "];
            valuesFlag = [valuesFlag substringWithRange:NSMakeRange(0, valuesFlag.length -1)];
            valuesFlag = [valuesFlag stringByAppendingString:@")"];
            insertStr = [insertStr stringByAppendingString:valuesFlag];
            NSLog(@"%@",insertStr);
            sqlite3_stmt *stmt;
            if(sqlite3_prepare_v2(database, [insertStr UTF8String], -1, &stmt, nil) == SQLITE_OK){
                int j = 0;
                for (itemInformation *aitem in oneitem.informations) {
                    
                    if ([aitem.valueType isEqualToString:kItemTypeInteger]) {
                        sqlite3_bind_int(stmt, j+1, [aitem.value  intValue]);
                    }else if ([aitem.valueType  isEqualToString:kItemTypeText]) {
                        sqlite3_bind_text(stmt, j+1, [aitem.value  UTF8String],-1,NULL);
                    }else if ([aitem.valueType  isEqualToString:kItemTypeDouble]) {
                        sqlite3_bind_double(stmt, j+1, [aitem.value  doubleValue]);
                    }
                    j++;
                }

                int t = sqlite3_step(stmt);
                NSLog(@"%d",t);
                if (t != SQLITE_DONE) { // 判断是否查询成功
                    sqlite3_finalize(stmt); // 释放stmt
                    sqlite3_close(database); // 关闭数据库
                    NSLog(@"插入失败");
                    return NO;
                }else{
                    sqlite3_finalize(stmt);
                    sqlite3_close(database);
                    NSLog(@"插入成功");
                    return YES;
                }
            }
        }
    }else{
        NSLog(@"数据库连接失败");
        return NO;
    }
    return YES;
}

//删除item
- (BOOL)deleteitemsInTable:(NSString *)tabalName whereDlete:(NSString *)whereDlete{
    if([self openDB]){
        NSString *delereStr = [NSString stringWithFormat:@"DELETE FROM %@ where %@",tabalName,whereDlete];
        sqlite3_stmt *stmp = nil;
        int result = sqlite3_prepare(database, [delereStr UTF8String], -1, &stmp, NULL);
        if(result == SQLITE_OK){
            int t = sqlite3_step(stmp);
            if(t != SQLITE_DONE){
                NSLog(@"删除失败");
                sqlite3_finalize(stmp);
                sqlite3_close(database);
                return NO;
            }else{
                NSLog(@"%d",t);
                NSLog(@"删除成功");
                sqlite3_finalize(stmp);
                sqlite3_close(database);
                return YES;
            }
        }else{
            NSLog(@"删除失败");
            sqlite3_finalize(stmp);
            sqlite3_close(database);
            return NO;
        }
    }else{
        return NO;
    }
    
}

//更新信息
- (BOOL)updataitemsInTable:(NSString *)tabalName setString:(NSArray *)setArray whereUpdata:(NSString *)whereUpdata{
    if([self openDB]){
        sqlite3_stmt *stmt = nil;
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET " ,tabalName];
        for(NSString *str in setArray){
            sql = [sql stringByAppendingString:[NSString stringWithFormat:@"%@,",str]];
        }
        sql = [sql substringWithRange:NSMakeRange(0, sql.length - 1)];
        sql = [sql stringByAppendingString:[NSString stringWithFormat:@" WHERE %@",whereUpdata]];
        NSLog(@"%@",sql);
        int result = sqlite3_prepare_v2(database, [sql UTF8String], -1, &stmt, NULL);
        if (result == SQLITE_OK) {
            int t = sqlite3_step(stmt);
            if(t != SQLITE_DONE){
                NSLog(@"修改失败");
                sqlite3_finalize(stmt);
                sqlite3_close(database);
                return NO;
            }else{
                NSLog(@"%d",t);
                NSLog(@"修改成功");
                sqlite3_finalize(stmt);
                sqlite3_close(database);
                return YES;
            }
        }else{
            NSLog(@"删除失败");
            sqlite3_finalize(stmt);
            sqlite3_close(database);
            return NO;
        }
    }else{
        return NO;
    }
}



/**
 *  从数据库中读取数据
 * 1.tableName:     表名
 * 2.items:         要查看的字段
 * 3.whereSelected: 条件语句
 * 4.orderType:     排序类型(升序或者降序)默认为升序
 * 5.orderBy:       排序字段
 * 6.orderItemTypes 各个字段的类型
 */
- (NSArray *)queryDataFromTable:(NSString *)tableName items:(NSArray *)items whereSelected:(NSArray *)whereSelected  orderType:(OrderByType)orderType orderBy:(NSArray *)orderBy orderItemType:(NSArray *)orderItemTypes{
    
    if([self openDB]){
        
        // 1.创建sql语句
        if (tableName == nil||items == nil||items.count == 0) { // 如果一些必要数据缺少,则返回nil
            sqlite3_close(database);
            return nil;
        }
        NSMutableArray *resultArr = [NSMutableArray array];
        // 添加要查询的字段
        NSString *querySql = @"SELECT ";
        for (int i = 0; i < items.count; i++) {
            NSString *item = [NSString stringWithFormat:@"%@,",items[i]];
            querySql = [querySql stringByAppendingString:item];
        }
        querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length - 1)];
        NSString *fromTab = [NSString stringWithFormat:@" FROM %@ ",tableName];
        querySql = [querySql stringByAppendingString:fromTab];
        
        // 添加查询条件的字段
        if(whereSelected != nil && whereSelected.count > 0) {
            querySql = [querySql stringByAppendingString:@" WHERE "];
            for (int j = 0; j < whereSelected.count; j++) {
                NSString *oneSelect = [NSString stringWithFormat:@" %@ ,",whereSelected[j]];
                querySql = [querySql stringByAppendingString:oneSelect];
            }
            querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length -1)];
        }
        // 添加排序字段
        if(orderBy != nil && orderBy.count > 0) {
            querySql = [querySql stringByAppendingString:@" ORDER BY "];
            
            for(int m = 0;m < orderBy.count; m++) {
                NSString *orderStr = [NSString stringWithFormat:@"%@,",orderBy[m]];
                querySql = [querySql stringByAppendingString:orderStr];
            }
            querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length - 1)];
            
            if(orderType == OrderByTypeDown) { // 降序
                querySql = [querySql stringByAppendingString:@" desc"];
            }
            //            else{ // 默认为升序
            // 升序中sql语句中不做任何处理
            //            }
        }
        NSLog(@"----sql----------------%@",querySql);
        sqlite3_stmt *stmt;
        sqlite3_prepare_v2(database, [querySql UTF8String], -1, &stmt, nil);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int n = 0; n < items.count; n++) {
                if ([orderItemTypes[n] isEqualToString:kItemTypeInteger]) {
                    int value = sqlite3_column_int(stmt, n);
                    [dict setObject:[NSNumber numberWithInt:value] forKey:items[n]];
                }else if ([orderItemTypes[n] isEqualToString:kItemTypeText]) {
                    const unsigned char *value = sqlite3_column_text(stmt, n);
                    [dict setObject:[NSString stringWithUTF8String:(char*)value] forKey:items[n]];
                }else if ([orderItemTypes[n] isEqualToString:kItemTypeDouble]) {
                    double value = sqlite3_column_double(stmt, n);
                    [dict setObject:[NSNumber numberWithDouble:value] forKey:items[n]];
                }
            }
            NSLog(@"%@",dict);
            [resultArr addObject:dict];
        }
        sqlite3_close(database);
        return resultArr;
    }
    return nil;
}

- (NSArray *)queryDataFromMoreTable:(NSArray *)tableName items:(NSArray *)items whereSelected:(NSArray *)whereSelected  orderType:(OrderByType)orderType orderBy:(NSArray *)orderBy orderItemType:(NSArray *)orderItemTypes{
    
    if([self openDB]){
        
        // 1.创建sql语句
        if (tableName == nil||items == nil||items.count == 0) { // 如果一些必要数据缺少,则返回nil
            sqlite3_close(database);
            return nil;
        }
        NSMutableArray *resultArr = [NSMutableArray array];
        // 添加要查询的字段
        NSString *querySql = @"SELECT ";
        for (int i = 0; i < items.count; i++) {
            NSString *item = [NSString stringWithFormat:@"%@,",items[i]];
            querySql = [querySql stringByAppendingString:item];
        }
        querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length - 1)];
        querySql = [querySql stringByAppendingString:@" FROM"];
        
        for(NSString *table in tableName){
            querySql = [querySql stringByAppendingString:[NSString stringWithFormat:@" %@,",table]];
        }
        querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length - 1)];
        // 添加查询条件的字段
        if(whereSelected != nil && whereSelected.count > 0) {
            querySql = [querySql stringByAppendingString:@" WHERE "];
            for (int j = 0; j < whereSelected.count; j++) {
                NSString *oneSelect = [NSString stringWithFormat:@" %@ and",whereSelected[j]];
                querySql = [querySql stringByAppendingString:oneSelect];
            }
            querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length -3)];
        }
        // 添加排序字段
        if(orderBy != nil && orderBy.count > 0) {
            querySql = [querySql stringByAppendingString:@" ORDER BY "];
            
            for(int m = 0;m < orderBy.count; m++) {
                NSString *orderStr = [NSString stringWithFormat:@"%@,",orderBy[m]];
                querySql = [querySql stringByAppendingString:orderStr];
            }
            querySql = [querySql substringWithRange:NSMakeRange(0, querySql.length - 1)];
            
            if(orderType == OrderByTypeDown) { // 降序
                querySql = [querySql stringByAppendingString:@" desc"];
            }
            //            else{ // 默认为升序
            // 升序中sql语句中不做任何处理
            //            }
        }
        NSLog(@"----sql----------------%@",querySql);
        sqlite3_stmt *stmt;
        sqlite3_prepare_v2(database, [querySql UTF8String], -1, &stmt, nil);
        
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            for (int n = 0; n < items.count; n++) {
                if ([orderItemTypes[n] isEqualToString:kItemTypeInteger]) {
                    int value = sqlite3_column_int(stmt, n);
                    [dict setObject:[NSNumber numberWithInt:value] forKey:items[n]];
                }else if ([orderItemTypes[n] isEqualToString:kItemTypeText]) {
                    const unsigned char *value = sqlite3_column_text(stmt, n);
                    [dict setObject:[NSString stringWithUTF8String:(char*)value] forKey:items[n]];
                }else if ([orderItemTypes[n] isEqualToString:kItemTypeDouble]) {
                    double value = sqlite3_column_double(stmt, n);
                    [dict setObject:[NSNumber numberWithDouble:value] forKey:items[n]];
                }
            }
            NSLog(@"%@",dict);
            [resultArr addObject:dict];
        }
        sqlite3_close(database);
        return resultArr;
    }
    return nil;
}


//检测表是否存在
- (BOOL)checkName:(NSString *)aTableName{
    BOOL exist = NO;
    if([self openDB]){
        sqlite3_stmt *stmt;
        
        NSString *judgeString = [NSString stringWithFormat:@"SELECT name FROM sqlite_master where type ='table' and name = '%@';",aTableName];
        const char *sql_stmt = [judgeString UTF8String];
        
        if (sqlite3_prepare_v2(database, sql_stmt, -1, &stmt, nil) == SQLITE_OK)
        {
            int temp = sqlite3_step(stmt);
            if (temp == SQLITE_ROW)
            {
                exist = YES;
            } else
            {
                NSLog(@"temp = %d",temp);
            }
        }
        
        sqlite3_finalize(stmt);
    }
    return exist;
}

- (NSString *)dataBasePath{
    if(!_dataBasePath){
        NSArray *documentArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentPath = [documentArr firstObject];
        NSLog(@"%@",documentPath);
        // crylown.db 为数据库的名字
        NSString *path = [NSString stringWithFormat:@"%@/my.db",documentPath];
        _dataBasePath = path;
    }
    
    return _dataBasePath;
}

@end
