//
//  selectController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "selectController.h"
#import "selectViewModel.h"
#import "subjectData.h"
#import "ZLSSqlite.h"
#import "personalData.h"
#import "subjecdetailController.h"

@interface selectController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *selectTableView;
}

@property (strong ,nonatomic) NSMutableArray <subjectData *>* courseArray;

@property (nonatomic, strong)selectViewModel *viewModel;

@end

@implementation selectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[selectViewModel alloc] init];
    [self setFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)setFrame{
    self.title = @"已选信息";
    UITableView *selectSubjectTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    selectSubjectTableView.delegate = self;
    selectSubjectTableView.dataSource = self;
    selectSubjectTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:selectSubjectTableView];
    selectTableView = selectSubjectTableView;
}

- (void)getData{
    [self.courseArray removeAllObjects];
    __weak __typeof(self)weakSelf = self;
    [self.viewModel fetchSelectData:^(id returnValue) {
        weakSelf.courseArray = (NSMutableArray *)[returnValue mutableCopy];
        [selectTableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.courseArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *str = [NSString stringWithFormat:@"%ld",self.courseArray[indexPath.row].cno];
        if([[ZLSSqlite defaultZLSSqlite] deleteitemsInTable:@"student_course_5470" whereDlete:[NSString stringWithFormat:@"c_no = %@",str]]){
            [self.courseArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        };
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"退选";
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
    cell.textLabel.text = self.courseArray[indexPath.row].cname;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
    [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
    [label1 setText:[NSString stringWithFormat:@"%ld 学分",self.courseArray[indexPath.row].credit]];
    label1.textAlignment = NSTextAlignmentRight;
    [label1 setFont:[UIFont systemFontOfSize:17]];
    [cell.contentView addSubview:label1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    subjecdetailController *vc = [[subjecdetailController alloc] initWithSubjec:_courseArray[indexPath.row]];
    vc.isSelect = YES;
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
}

- (NSMutableArray <subjectData *>*)courseArray{
    if(!_courseArray){
        _courseArray = [NSMutableArray array];
    }
    return _courseArray;
}
@end
