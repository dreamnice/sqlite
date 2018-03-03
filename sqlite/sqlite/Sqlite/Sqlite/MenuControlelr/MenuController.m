//
//  MenuController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "MenuController.h"
#import "menuCellTableViewCell.h"
#import "personalData.h"
#import "personalDetailController.h"
#import "selecetSubjectController.h"
#import "selectController.h"
#import "checkScoreController.h"
#import "editScoreController.h"
#import "checkStudentController.h"
#import "AppDelegate.h"

@interface MenuController ()<UITableViewDelegate,UITableViewDataSource>{
    UITableView *personalTableView;
}

@end

@implementation MenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{
                          NSForegroundColorAttributeName : [UIColor whiteColor]
                          };
    self.navigationController.navigationBar.titleTextAttributes = dic;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:84/255.0 green:149/255.0 blue:251/255.0 alpha:1];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    self.title = @"菜单";
    [self setFrame];
}

- (void)setFrame{
    personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 120) style:UITableViewStylePlain];
    personalTableView.delegate = self;
    personalTableView.dataSource = self;
    personalTableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    personalTableView.tableFooterView = [[UIView alloc] init];
    personalTableView.scrollEnabled = NO;
    [self.view addSubview:personalTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellidentifier = @"cell";
    menuCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
    if(cell == nil){
        cell = [[menuCellTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellidentifier];
    }
    switch (indexPath.row) {
        case 0:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"ic_user"]];
            cell.titleLabel.text = [personalData sharedData].name;
            cell.subtitleLabel.text = [personalData sharedData].dno;
        }
            break;
        case 1:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"ic_class_schedule"]];
            cell.titleLabel.frame = CGRectMake(75, 15, 100, 25);
            if([personalData sharedData].isTeacher){
                cell.titleLabel.text = @"课程信息";
            }else{
                cell.titleLabel.text = @"选课信息";
            }
            NSLog(@"%@",cell.titleLabel.text);
            NSLog(@"%@",cell.subtitleLabel.text);
        }
            break;
        case 2:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"ic_grades"]];
            cell.titleLabel.frame = CGRectMake(75, 15, 100, 25);
            if([personalData sharedData].isTeacher){
                cell.titleLabel.text = @"成绩修改";
            }else{
                cell.titleLabel.text = @"已选课程";
            }
        }
            break;
        case 3:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"ic_exam"]];
            cell.titleLabel.frame = CGRectMake(75, 15, 100, 25);
            if([personalData sharedData].isTeacher){
                cell.titleLabel.text = @"学生查询";
            }else{
                cell.titleLabel.text = @"成绩查询";
            }
        }
            break;
        case 4:{
            [cell.iconImageView setImage:[UIImage imageNamed:@"ic_computer"]];
            cell.titleLabel.frame = CGRectMake(75, 15, 100, 25);
            cell.titleLabel.text = @"登出";
        }
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:{
            personalDetailController *vc = [[personalDetailController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            selecetSubjectController *vc = [[selecetSubjectController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:{
            if([personalData sharedData].isTeacher){
                editScoreController *vc = [[editScoreController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                selectController *vc = [[selectController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            
        }
            break;
        case 3:{
            if([personalData sharedData].isTeacher){
                checkStudentController *vc = [[ checkStudentController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                checkScoreController *vc = [[checkScoreController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
        }
            break;
        case 4:{
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [app showMain];
        }
            break;
        default:
            break;
    }
    
}

@end
