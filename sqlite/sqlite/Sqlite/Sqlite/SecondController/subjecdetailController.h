//
//  subjecdetailController.h
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subjectData.h"

@interface subjecdetailController : UIViewController

- (id)initWithSubjec:(subjectData *)subject;

@property (assign ,nonatomic)BOOL isSelect;

@end
