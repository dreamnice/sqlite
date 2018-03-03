//
//  checkStudentController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "checkStudentController.h"
#import "studentData.h"
#import "editStudentDetail.h"
#import "ZLSSqlite.h"

@interface checkStudentController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSString *search;
    UITableView *checktable;
}

@property (nonatomic, strong) UISearchBar *searchBar;

@property (strong ,nonatomic) NSMutableArray <studentData *>* dataArray;

@end

@implementation checkStudentController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setframe];
    [self setBarButtonItem];
    search = @"";
}

- (void)setframe{
    UITableView *check = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    check.delegate = self;
    check.dataSource = self;
    check.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:check];
    checktable = check;
}


- (void)getdata{
    [self.dataArray removeAllObjects];
    NSArray *tablename = @[@"student_5470",@"department_5470"];
    NSArray *array = [[[ZLSSqlite defaultZLSSqlite] queryDataFromMoreTable:tablename items:@[@"student_5470.s_name",@"student_5470.s_sex",@"student_5470.s_birthday",@"student_5470.s_no",@"department_5470.d_name"] whereSelected:@[[NSString stringWithFormat:@"student_5470.s_name LIKE '%%%@%%'",search] , @"department_5470.d_no = student_5470.s_dno"] orderType:OrderByTypeUp orderBy:@[@"student_5470.s_name"] orderItemType:@[kItemTypeText,kItemTypeText,kItemTypeDouble,kItemTypeInteger,kItemTypeText]] copy];
    NSLog(@"%@",array);
    for(NSDictionary *dic in array){
        studentData *data = [[studentData alloc] init];
        data.name = dic[@"student_5470.s_name"];
        data.sex = dic[@"student_5470.s_sex"];
        data.sno = [NSString stringWithFormat:@"%ld",[dic[@"student_5470.s_no"] integerValue]];
        data.dno = dic[@"department_5470.d_name"];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dic[@"student_5470.s_birthday"] doubleValue]]];
        data.birthday = timeString;
        [self.dataArray addObject:data];
    }
    [checktable reloadData];
}

- (void)setBarButtonItem
{
    //隐藏导航栏上的返回按钮
    [self.navigationItem setHidesBackButton:YES];
    //用来放searchBar的View
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    //创建searchBar
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];
    //默认提示文字
    searchBar.placeholder = @"搜索内容";
    //背景图片
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    //代理
    searchBar.delegate = self;
    //显示右侧取消按钮
    searchBar.showsCancelButton = YES;
    //光标颜色
    searchBar.tintColor = [UIColor colorWithRed:125/255.0 green:160/255.0 blue:245/255.0 alpha:1];
    //拿到searchBar的输入框
    UITextField *searchTextField = [searchBar valueForKey:@"_searchField"];
    //字体大小
    searchTextField.font = [UIFont systemFontOfSize:15];
    searchTextField.placeholder = @"请输入学生姓名";
    //输入框背景颜色
    searchTextField.backgroundColor = [UIColor colorWithRed:234/255.0 green:235/255.0 blue:237/255.0 alpha:1];
    //拿到取消按钮
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //设置按钮上的文字
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    //设置按钮上文字的颜色
    [cancleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.dataArray.count;
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
    cell.textLabel.text = self.dataArray[indexPath.row].name;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(183, 10 , 185, 40)];
    [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
    [label1 setText:[NSString stringWithFormat:@"学号:%@",self.dataArray[indexPath.row].sno]];
    label1.textAlignment = NSTextAlignmentRight;
    [label1 setFont:[UIFont systemFontOfSize:17]];
    [cell.contentView addSubview:label1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.searchBar resignFirstResponder];
    editStudentDetail *vc = [[editStudentDetail alloc] initWithStudentData:self.dataArray[indexPath.row]];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    return YES;
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    searchBar.showsCancelButton = YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    NSLog(@"SearchButton");
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    search = searchText;
    [self.dataArray removeAllObjects];
    NSArray *tablename = @[@"student_5470",@"department_5470"];
    NSArray *array = [[[ZLSSqlite defaultZLSSqlite] queryDataFromMoreTable:tablename items:@[@"student_5470.s_name",@"student_5470.s_sex",@"student_5470.s_birthday",@"student_5470.s_no",@"department_5470.d_name"] whereSelected:@[[NSString stringWithFormat:@"student_5470.s_name LIKE '%%%@%%'",search] , @"department_5470.d_no = student_5470.s_dno"] orderType:OrderByTypeUp orderBy:@[@"student_5470.s_name"] orderItemType:@[kItemTypeText,kItemTypeText,kItemTypeDouble,kItemTypeInteger,kItemTypeText]] copy];
    NSLog(@"%@",array);
    for(NSDictionary *dic in array){
        studentData *data = [[studentData alloc] init];
        data.name = dic[@"student_5470.s_name"];
        data.sex = dic[@"student_5470.s_sex"];
        data.sno = [NSString stringWithFormat:@"%ld",[dic[@"student_5470.s_no"] integerValue]];
        data.dno = dic[@"department_5470.d_name"];
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSString *timeString = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[dic[@"student_5470.s_birthday"] doubleValue]]];
        data.birthday = timeString;
        [self.dataArray addObject:data];
    
    }
    [checktable reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

- (NSMutableArray <studentData *>*)dataArray{
    if(!_dataArray){
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end
