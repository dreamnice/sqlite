//
//  itemInformation.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "itemInformation.h"

@implementation itemInformation

- (id)initWithValue:(id)value Name:(NSString *)name ValueType:(NSString *)valueType headvalueType:(NSString *)headvalueType{
    if([super init]){
        _value = value;
        _name = name;
        _valueType = valueType;
        _heandvalueType = headvalueType;
    }
    return self;
}


@end
