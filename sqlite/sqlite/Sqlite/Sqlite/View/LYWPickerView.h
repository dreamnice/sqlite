//
//  LYWPickerView.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYWPickerViewDelegate <NSObject>

@optional

- (void)pickViewSureBtnClick:(NSString *)selectRow pickView:(id)pickView;

@end

@interface LYWPickerView : UIView

/*** 提供出一个数组 方便外面传递 ***/
@property (strong, nonatomic) NSMutableArray *NumberArr;

@property (weak, nonatomic)id<LYWPickerViewDelegate> delegate;

@end


