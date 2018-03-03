//
//  addNewSubjectController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "addNewSubjectController.h"
#import "CZHDatePickerView.h"
#import "DatePickerHeader.h"
#import "courseItem.h"
#import "ZLSSqlite.h"
#import "personalData.h"

@interface addNewSubjectController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITextField *nametextField;
    UITextField *cnotextField;
    UITextField *chourField;
    UITextField *creditField;
    UITextField *cplacetField;
    UILabel *ctnolabel;
    UILabel *ctimelabel;
    UILabel *testtimelabel;

}

@end

@implementation addNewSubjectController

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
    self.title = @"添加课程";
    
    UIBarButtonItem *baritem1 = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(rightdoneClick)];
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
        switch (indexPath.row) {
            case 0:{
                [cell.textLabel setText:@"课程名称"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.placeholder = @"数据库";
                textfield.delegate = self;
                nametextField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 1:{
                [cell.textLabel setText:@"课程号"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.keyboardType = UIKeyboardTypeNumberPad;
                textfield.delegate = self;
                cnotextField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 2:{
                [cell.textLabel setText:@"任课教师号"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                label1.text = [NSString stringWithFormat:@"%ld",[personalData sharedData].sno];
                [label1 setTextColor:[UIColor lightGrayColor]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
                ctnolabel = label1;
            }
                break;
            case 3:{
                [cell.textLabel setText:@"学时"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.keyboardType = UIKeyboardTypeNumberPad;
                textfield.delegate = self;
                chourField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 4:{
                [cell.textLabel setText:@"学分"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.keyboardType = UIKeyboardTypeNumberPad;
                textfield.delegate = self;
                creditField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 5:{
                [cell.textLabel setText:@"上课地点"];
                UITextField *textfield = [[UITextField alloc] initWithFrame:CGRectMake(100, 10 , 250, 40)];
                [textfield setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                [textfield setFont:[UIFont systemFontOfSize:17]];
                [textfield setTextAlignment:NSTextAlignmentRight];
                textfield.returnKeyType = UIReturnKeyDone;
                textfield.delegate = self;
                cplacetField = textfield;
                [cell.contentView addSubview:textfield];
            }
                break;
            case 6:{
                [cell.textLabel setText:@"上课时间"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                //[label1 setText:[personalData sharedData].dno];
                [label1 setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
                ctimelabel = label1;
                
            }
                break;
            case 7:{
                [cell.textLabel setText:@"考试时间"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                //[label1 setText:[personalData sharedData].dno];
                [label1 setTextColor:[UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
                testtimelabel = label1;
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
            [cnotextField becomeFirstResponder];
        }
            break;
        case 2:{
            
        }
            break;
        case 3:{
            [chourField becomeFirstResponder];
        }
            break;
        case 4:{
            [creditField becomeFirstResponder];
        }
            break;
        case 5:{
            [cplacetField becomeFirstResponder];
        }
            break;
        case 6:{
            [CZHDatePickerView sharePickerViewWithCurrentDate:@"" isMax:NO DateBlock:^(NSString *dateString) {
                ctimelabel.text = dateString;
            }];
        }
            break;
        case 7:{
            [CZHDatePickerView sharePickerViewWithCurrentDate:@"" isMax:NO DateBlock:^(NSString *dateString) {
                testtimelabel.text = dateString;
            }];
        }
            break;
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
    if([cnotextField.text isEqualToString:@""] || cnotextField.text == nil || [nametextField.text isEqualToString:@""] || nametextField.text == nil || [creditField.text isEqualToString:@""] || creditField.text == nil || [chourField.text isEqualToString:@""] || chourField.text == nil || [cplacetField.text isEqualToString:@""] || cplacetField.text == nil || [ctimelabel.text isEqualToString:@""] || ctimelabel.text == nil ||  [testtimelabel.text isEqualToString:@""] || testtimelabel.text == nil || [ctnolabel.text isEqualToString:@""] || ctnolabel.text == nil){
        [self SetAlert:@"信息不全"];
    }else{
        if([cnotextField.text integerValue] > 1000 || [cnotextField.text integerValue] < 0){
            [self SetAlert:@"课程号格式错误"];
        }else{
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:FORMAT];
            NSDate *ctimeate = [dateFormatter dateFromString:ctimelabel.text];
            NSDate *testdate = [dateFormatter dateFromString:testtimelabel.text];
            NSInteger hour = [chourField.text integerValue];
            NSInteger crdit = [creditField.text integerValue];
            NSInteger cno = [cnotextField.text integerValue];
            NSInteger tno = [ctnolabel.text integerValue];
            
            courseItem *item = [[courseItem alloc] initWithCno:cno cname:nametextField.text tno:tno credit:crdit chour:hour ctime:ctimeate cplace:cplacetField.text testTime:testdate];
            if([[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item]){
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                [self SetAlert:@"添加课程失败"];
            };
        }
        
    }
}

- (void)leftdoneClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//弹出提示消息
- (void)SetAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
