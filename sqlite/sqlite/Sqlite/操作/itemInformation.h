//
//  itemInformation.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface itemInformation : NSObject

@property id value;

@property (copy ,readonly ,nonatomic) NSString *name;

@property (copy ,readonly ,nonatomic) NSString *valueType;

@property (copy ,readonly ,nonatomic)NSString *heandvalueType;

- (id)initWithValue:(id)value Name:(NSString *)name ValueType:(NSString *)valueType headvalueType:(NSString *)headvalueType;

@end
