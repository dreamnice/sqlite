//
//  subjecdetailController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/17.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "subjecdetailController.h"
#import "personalData.h"
#import "studentCourseItem.h"
#import "ZLSSqlite.h"

@interface subjecdetailController ()<UITableViewDelegate,UITableViewDataSource>{
    subjectData *data;
}

@end

@implementation subjecdetailController

- (id)initWithSubjec:(subjectData *)subject{
    if([super init]){
        data = subject;
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
    self.title = data.cname;
    
    if(![personalData sharedData].isTeacher && !_isSelect){
        UIBarButtonItem *baritem1 = [[UIBarButtonItem alloc] initWithTitle:@"选课" style:UIBarButtonItemStylePlain target:self action:@selector(rightdoneClick)];
        self.navigationItem.rightBarButtonItem = baritem1;
    }
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
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setText:data.cname];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
       
            }
                break;
            case 1:{
                [cell.textLabel setText:@"课程号"];

                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setText:[NSString stringWithFormat:@"%ld",data.cno]];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
            }
                break;
            case 2:{
                [cell.textLabel setText:@"任课教师号"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                label1.text = [NSString stringWithFormat:@"%ld",data.tno];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
          
            }
                break;
            case 3:{
                [cell.textLabel setText:@"学时"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setText:[NSString stringWithFormat:@"%ld",data.chour]];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
            }
                break;
            case 4:{
                [cell.textLabel setText:@"学分"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setText:[NSString stringWithFormat:@"%ld",data.credit]];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
            }
                break;
            case 5:{
                [cell.textLabel setText:@"上课地点"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                [label1 setText:data.cplace];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
            }
                break;
            case 6:{
                [cell.textLabel setText:@"上课时间"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *timeString = [formatter stringFromDate:data.ctime];
                [label1 setText:timeString];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
          
                
            }
                break;
            case 7:{
                [cell.textLabel setText:@"考试时间"];
                UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
                NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
                //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSString *timeString = [formatter stringFromDate:data.testTime];
                [label1 setText:timeString];
                [label1 setTextColor:[UIColor colorWithRed:97/255.0 green:164/255.0 blue:54/255.0 alpha:1]];
                label1.textAlignment = NSTextAlignmentRight;
                [label1 setFont:[UIFont systemFontOfSize:17]];
                [cell.contentView addSubview:label1];
            
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

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

- (void)rightdoneClick{
    NSInteger t = 0;
    studentCourseItem *item = [[studentCourseItem alloc] initWithSno:[personalData sharedData].sno cno:data.cno score:t];
    if([[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item]){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self SetAlert:@"选课失败"];
    };
}

//弹出提示消息
- (void)SetAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:act];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)leftdoneClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
