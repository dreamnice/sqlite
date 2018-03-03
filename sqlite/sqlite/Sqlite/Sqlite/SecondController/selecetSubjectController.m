//
//  selecetSubjectController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "selecetSubjectController.h"
#import "subjectData.h"
#import "ZLSSqlite.h"
#import "personalData.h"

#import "addNewSubjectController.h"
#import "subjecdetailController.h"
#import "editSubjectController.h"

@interface selecetSubjectController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView *selectTableView;
}

@property (strong ,nonatomic) NSMutableArray <subjectData *>* courseArray;

@end

@implementation selecetSubjectController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrame];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

- (void)setFrame{
    if(![personalData sharedData].isTeacher){
        self.title = @"选课信息";
    }else{
        self.title = @"课程信息";
        UIView *rightbarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.0583 * self.view.frame.size.width, 0.0583 * self.view.frame.size.width)];
        UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 0.0583 * self.view.frame.size.width, 0.0583 * self.view.frame.size.width)];
        [btn2 setImage:[UIImage imageNamed:@"plus"] forState:0];
        [btn2 addTarget:self action:@selector(rightBtnMethod) forControlEvents:UIControlEventTouchUpInside];
        [rightbarView addSubview:btn2];
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:rightbarView];
        self.navigationItem.rightBarButtonItem = right;
    }
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
    NSArray *array = [[[ZLSSqlite defaultZLSSqlite] queryDataFromTable:@"course_5470" items:@[@"c_no",@"c_name",@"t_no",@"credit",@"c_hour",@"c_time",@"c_place",@"c_testtime"] whereSelected:nil orderType:OrderByTypeUp orderBy:@[@"c_no"]  orderItemType:@[kItemTypeInteger,kItemTypeText,kItemTypeInteger,kItemTypeInteger,kItemTypeInteger,kItemTypeDouble,kItemTypeText,kItemTypeDouble]] mutableCopy];
    NSLog(@"%@",array);
    for(NSDictionary *dic in array){
        subjectData *data = [[subjectData alloc] initWithCno:[dic[@"c_no"] integerValue] cname:dic[@"c_name"] tno:[dic[@"t_no"] integerValue] credit:[dic[@"credit"] integerValue] chour:[dic[@"c_hour"] integerValue] ctime:[NSDate dateWithTimeIntervalSince1970:[dic[@"c_time"] doubleValue]] cplace:dic[@"c_place"] testTime:[NSDate dateWithTimeIntervalSince1970:[dic[@"c_testtime"] doubleValue]]];
        [self.courseArray addObject:data];
    }
    [selectTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.courseArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [personalData sharedData].isTeacher;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *str = [NSString stringWithFormat:@"%ld",self.courseArray[indexPath.row].cno];
        if(self.courseArray[indexPath.row].tno == [personalData sharedData].sno){
            if([[ZLSSqlite defaultZLSSqlite] deleteitemsInTable:@"course_5470" whereDlete:[NSString stringWithFormat:@"c_no = %@",str]]){
                [self.courseArray removeObjectAtIndex:indexPath.row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            };
        }
    }
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
    if([personalData sharedData].isTeacher && [personalData sharedData].sno == _courseArray[indexPath.row].tno){
        editSubjectController *vc = [[editSubjectController alloc] initWithSubject:_courseArray[indexPath.row]];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navc animated:YES completion:nil];
    }else{
        subjecdetailController *vc = [[subjecdetailController alloc] initWithSubjec:_courseArray[indexPath.row]];
        UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:navc animated:YES completion:nil];
    }

}

- (void)rightBtnMethod{
    addNewSubjectController *vc = [[addNewSubjectController alloc] init];
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
