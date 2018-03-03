//
//  editeScoreDetaiControllerViewController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/18.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "editeScoreDetaiController.h"
#import "personalData.h"
#import "ZLSSqlite.h"

@interface editeScoreDetaiController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    scoreAndPersonalData *data;
    UITextField *scoretextfield;
}

@end

@implementation editeScoreDetaiController

- (id)initWithData:(scoreAndPersonalData *)scoredata{
    if([super init]){
        data = scoredata;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor]
                          };
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"修改成绩";
    [self setframe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setframe{
    UIBarButtonItem *baritem1 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightdoneClick)];
    self.navigationItem.rightBarButtonItem = baritem1;
    
    UIBarButtonItem *baritem2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftdoneClick)];
    self.navigationItem.leftBarButtonItem = baritem2;
    
    UITableView *personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    personalTableView.delegate = self;
    personalTableView.dataSource = self;
    personalTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:personalTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    switch (indexPath.row) {
        case 0:{
            [cell.textLabel setText:@"姓名"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.name];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 1:{
            [cell.textLabel setText:@"性别"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.sex];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 2:{
            [cell.textLabel setText:@"学号"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.sno];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 3:{
            [cell.textLabel setText:@"出生年月"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.birthday];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 4:{
            [cell.textLabel setText:@"院系"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.dname];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 5:{
            [cell.textLabel setText:@"分数"];
            UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
            [textfield setFont:[UIFont systemFontOfSize:17]];
            [textfield setTextAlignment:NSTextAlignmentRight];
            textfield.returnKeyType = UIReturnKeyDone;
            textfield.keyboardType = UIKeyboardTypeNumberPad;
            textfield.delegate = self;
            [textfield setText:data.score];
            if([[NSString stringWithFormat:@"%ld",[personalData sharedData].sno] isEqualToString:data.tno]){
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
            }else{
                [textfield setTextColor:[UIColor lightGrayColor]];
                textfield.enabled = NO;
            }
            scoretextfield = textfield;
            [cell.contentView addSubview:textfield];
        }
            break;
        case 6:{
            [cell.textLabel setText:@"课程名称"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.cname];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 7:{
            [cell.textLabel setText:@"课程编号"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:data.cno];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        default:
            break;
    }
    return cell;
}

#pragma  mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(indexPath.row == 5){
        [scoretextfield becomeFirstResponder];
    }
}

- (void)leftdoneClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightdoneClick{
    if([scoretextfield.text integerValue] > 100 || [scoretextfield.text integerValue] < 0){
        [self SetAlert:@"分数错误"];
    }else{
        if([[ZLSSqlite defaultZLSSqlite] updataitemsInTable:@"student_course_5470" setString:@[ [NSString stringWithFormat:@"s_score = %@",scoretextfield.text]] whereUpdata:[NSString stringWithFormat:@"c_no = %@ and s_no = %@",data.cno,data.sno]]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self SetAlert:@"保存失败"];
        }
        
    }
}

//弹出提示消息
- (void)SetAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
