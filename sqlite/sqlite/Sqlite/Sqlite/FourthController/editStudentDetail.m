//
//  RegisterController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "editStudentDetail.h"
#import "CZHDatePickerView.h"
#import "DatePickerHeader.h"
#import "ZLSSqlite.h"
#import "studentItem.h"
#import "LYWPickerView.h"
#import "teacherItem.h"

@interface editStudentDetail ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,LYWPickerViewDelegate>{
    UITextField *nametextField;
    UITextField *snotextField;
    UILabel *sexlabel;
    UILabel *dnolabel;
    UILabel *birthlabel;
    
    studentData *data;
}

@end

@implementation editStudentDetail

- (id)initWithStudentData:(studentData *)studentdata{
    if([super init]){
        data = studentdata;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setFrame];
}

- (void)setFrame{
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor]
                          };
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"修改学生信息";
    
    UIBarButtonItem *baritem1 = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(rightdoneClick)];
    self.navigationItem.rightBarButtonItem = baritem1;
    
    UIBarButtonItem *baritem2 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(leftdoneClick)];
    self.navigationItem.leftBarButtonItem = baritem2;
    
    UITableView *subjectInfo = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    subjectInfo.delegate = self;
    subjectInfo.dataSource = self;
    subjectInfo.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:subjectInfo];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
        switch (indexPath.row) {
            case 0:{
                [cell.textLabel setText:@"姓名"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.text = data.name;
                textfield.delegate = self;
                nametextField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 1:{
                [cell.textLabel setText:@"学号"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor lightGrayColor]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.keyboardType = UIKeyboardTypeNumberPad;
                textfield.text = data.sno;
                textfield.enabled = NO;
                textfield.delegate = self;
                snotextField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 2:{
                [cell.textLabel setText:@"性别"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                label1.text = data.sex;
                [cell.contentView addSubview:label1];
                sexlabel = label1;
            }
                break;
            case 3:{
                [cell.textLabel setText:@"出生日期"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                label1.text = data.birthday;
                [cell.contentView addSubview:label1];
                birthlabel = label1;
            }
                break;
            case 4:{
                [cell.textLabel setText:@"院系"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                label1.text = data.dno;
                [cell.contentView addSubview:label1];
                dnolabel = label1;
            }
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view endEditing:YES];
    switch (indexPath.row) {
        case 0:{
            [nametextField becomeFirstResponder];
        }
            break;
        case 1:{
            [snotextField becomeFirstResponder];
        }
            break;
        case 2:{
            LYWPickerView *view = [[LYWPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            view.delegate = self;
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"男",@"女",nil];
            view.NumberArr = array;
            view.tag = 10;
            [self.view addSubview:view];
        }
            break;
        case 3:{
            [CZHDatePickerView sharePickerViewWithCurrentDate:@"" isMax:YES DateBlock:^(NSString *dateString) {
                birthlabel.text = dateString;
            }];
        }
            break;
        case 4:{
            LYWPickerView *view = [[LYWPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
            view.delegate = self;
            NSMutableArray *array = [NSMutableArray arrayWithObjects:@"计算机学院",@"外国语学院",@"管理学院",@"机电学院",nil];
            view.NumberArr = array;
            view.tag = 20;
            [self.view addSubview:view];
        }
        default:
            break;
    }
}

#pragma  mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


- (void)rightdoneClick{
    
    if([snotextField.text isEqualToString:@""] || snotextField.text == nil || [nametextField.text isEqualToString:@""] || nametextField.text == nil || [ birthlabel.text isEqualToString:@""] || birthlabel.text == nil ||  [dnolabel.text isEqualToString:@""] || dnolabel.text == nil || [sexlabel.text isEqualToString:@""] || sexlabel.text == nil){
        [self SetAlert:@"信息不全"];
    }else{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:FORMAT];
        NSDate *birthdate = [dateFormatter dateFromString:birthlabel.text];
        NSTimeInterval birth = [birthdate timeIntervalSince1970];
        NSString *birthstr = [NSString stringWithFormat:@"%lf",birth];
        NSString *dno;
        if([dnolabel.text isEqualToString:@"计算机学院"]){
            dno = @"100";
        }else if([dnolabel.text isEqualToString:@"外国语学院"]){
            dno = @"200";
        }else if([dnolabel.text isEqualToString:@"管理学院"]){
            dno = @"300";
        }else{
            dno = @"400";
        }
        if([[ZLSSqlite defaultZLSSqlite] updataitemsInTable:@"student_5470" setString:@[ [NSString stringWithFormat:@"s_name = '%@'",nametextField.text],[NSString stringWithFormat:@"s_sex = '%@'",sexlabel.text],[NSString stringWithFormat:@"s_dno = %@",dno],[NSString stringWithFormat:@"s_birthday = %@",birthstr]] whereUpdata:[NSString stringWithFormat:@"s_no = %@",data.sno]]){
            [self dismissViewControllerAnimated:YES completion:nil];
        }else{
            [self SetAlert:@"保存失败"];
        }
    }
}

- (void)leftdoneClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)pickViewSureBtnClick:(NSString *)selectRow pickView:(id)pickView{
    if(((LYWPickerView *)pickView).tag == 10){
        sexlabel.text = selectRow;
    }else{
        dnolabel.text = selectRow;
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
