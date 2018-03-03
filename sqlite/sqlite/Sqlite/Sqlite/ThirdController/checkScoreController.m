//
//  checkScoreControllerViewController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "checkScoreController.h"
#import "personalData.h"
#import "ZLSSqlite.h"
#import "scoreData.h"

@interface checkScoreController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *checkScoureTableview;
}
@property (strong ,nonatomic)NSMutableArray <scoreData *>* scoreArray;

@end

@implementation checkScoreController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrame];
    [self getData];
}

- (void)setFrame{
    self.title = @"成绩查询";
    UITableView *checkTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    checkTableView.delegate = self;
    checkTableView.dataSource = self;
    checkTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:checkTableView];
    checkScoureTableview = checkTableView;
}

- (void)getData{
    [self.scoreArray removeAllObjects];
    NSArray *tablename = @[@"course_5470",@"student_course_5470"];
    NSString *str = [NSString stringWithFormat:@"%ld",[personalData sharedData].sno];
    NSArray *array = [[[ZLSSqlite defaultZLSSqlite] queryDataFromMoreTable:tablename items:@[@"student_course_5470.s_score",@"course_5470.c_name"] whereSelected:@[[NSString stringWithFormat:@"student_course_5470.s_no = %@",str], @"student_course_5470.c_no = course_5470.c_no"] orderType:OrderByTypeUp orderBy:@[@"course_5470.c_no"] orderItemType:@[kItemTypeInteger,kItemTypeText]] mutableCopy];
    //    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    [formatter setDateFormat:@"yyyy-MM-dd"];
    for(NSDictionary *dic in array){
        scoreData *data = [[scoreData alloc] init];
        data.score = dic[@"student_course_5470.s_score"];
        data.name = dic[@"course_5470.c_name"];
        [self.scoreArray addObject:data];
    }
    [checkScoureTableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.scoreArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //删除并进行重新分配
        }
    }
    cell.textLabel.text = self.scoreArray[indexPath.row].name;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
    [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
    [label1 setText:[NSString stringWithFormat:@"%@ 分",self.scoreArray[indexPath.row].score]];
    label1.textAlignment = NSTextAlignmentRight;
    [label1 setFont:[UIFont systemFontOfSize:17]];
    [cell.contentView addSubview:label1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (NSMutableArray <scoreData *>*)scoreArray{
    if(!_scoreArray){
        _scoreArray = [NSMutableArray array];
    }
    return _scoreArray;
}
@end
