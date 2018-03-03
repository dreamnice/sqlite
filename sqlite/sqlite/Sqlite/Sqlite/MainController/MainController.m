//
//  MainController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/15.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "MainController.h"
#import "ZLSSqlite.h"
#import "studentItem.h"
#import "personalData.h"

#import "MenuController.h"
#import "RegisterController.h"
#import "AppDelegate.h"

@interface MainController ()
@property (weak, nonatomic) IBOutlet UIButton *pathBtn;

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;


@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor]
                          };
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1];
    self.title = @"登入";
}




- (IBAction)touchBtn:(UIButton *)sender {
    if(!_accountTextField.text||[_accountTextField.text isEqualToString:@""]){
        [self SetAlert:@"账号不能为空"];
    }else{
        if([_accountTextField.text integerValue] > 1000000){
            ZLSSqlite *zlssqlite = [ZLSSqlite defaultZLSSqlite];
            NSArray *array = [[zlssqlite queryDataFromTable:@"teacher_5470" items:@[@"t_no",@"t_name",@"t_sex",@"t_birthday",@"t_dno"] whereSelected:@[[NSString stringWithFormat:@"t_no = %@",_accountTextField.text ]] orderType:1 orderBy:nil orderItemType:@[kItemTypeInteger,kItemTypeText,kItemTypeText,kItemTypeDouble,kItemTypeInteger]] copy];
            NSLog(@"%@",array);
            if(array.count == 0){
                [self SetAlert:@"账号不存在"];
            }else{
                
                NSDictionary *dic = [array firstObject];
                NSString *str;
                switch ([dic[@"t_dno"] integerValue]) {
                    case 100:
                        str = @"计算机学院";
                        break;
                    case 200:{
                        str = @"外国语学院";
                    }
                        break;
                    case 300:{
                        str = @"管理学院";
                    }
                        break;
                    case 400:{
                        str = @"机电学院";
                    }
                        break;
                    default:
                        break;
                }
                
                
                NSDate *birthdate = [NSDate dateWithTimeIntervalSince1970:[dic[@"t_birthday"] doubleValue]];
                [[personalData sharedData] setDataWithSno:[dic[@"t_no"] integerValue] name:dic[@"t_name"] sex:dic[@"t_sex"] birthday:birthdate dno:str];
                [personalData sharedData].isTeacher = YES;
                [_accountTextField resignFirstResponder];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [app showMenu];
            }
        }else{
            ZLSSqlite *zlssqlite = [ZLSSqlite defaultZLSSqlite];
            NSArray *array = [[zlssqlite queryDataFromTable:@"student_5470" items:@[@"s_no",@"s_name",@"s_sex",@"s_birthday",@"s_dno"] whereSelected:@[[NSString stringWithFormat:@"s_no = %@",_accountTextField.text ]] orderType:1 orderBy:nil orderItemType:@[kItemTypeInteger,kItemTypeText,kItemTypeText,kItemTypeDouble,kItemTypeInteger]] copy];
   
            NSLog(@"%@",array);
            if(array.count == 0){
                [self SetAlert:@"账号不存在"];
            }else{
                NSDictionary *dic = [array firstObject];
                NSString *str;
                switch ([dic[@"s_dno"] integerValue]) {
                    case 100:
                        str = @"计算机学院";
                        break;
                    case 200:{
                        str = @"外国语学院";
                    }
                        break;
                    case 300:{
                        str = @"管理学院";
                    }
                        break;
                    case 400:{
                        str = @"机电学院";
                    }
                        break;
                    default:
                        break;
                }
                NSDate *birthdate = [NSDate dateWithTimeIntervalSince1970:[dic[@"s_birthday"] doubleValue]];
                NSLog(@"%@",dic[@"s_name"]);
                [[personalData sharedData] setDataWithSno:[dic[@"s_no"] integerValue] name:dic[@"s_name"] sex:dic[@"s_sex"] birthday:birthdate dno:str];
                [personalData sharedData].isTeacher = NO;
                [_accountTextField resignFirstResponder];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                [app showMenu];
            }
        }
    }
}

- (IBAction)regest:(id)sender {
    RegisterController *vc = [[RegisterController alloc] init];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:navc animated:YES completion:nil];
}

//弹出提示消息
- (void)SetAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
