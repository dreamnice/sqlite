//
//  personalDetailController.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/16.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "personalDetailController.h"
#import "personalData.h"

@interface personalDetailController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation personalDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self setframe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setframe{
    UITableView *personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    NSLog(@"%f",self.view.frame.size.width);
    personalTableView.delegate = self;
    personalTableView.dataSource = self;
    personalTableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:personalTableView];
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
    }
    switch (indexPath.row) {
        case 0:{
            [cell.textLabel setText:@"姓名"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:[personalData sharedData].name];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 1:{
            [cell.textLabel setText:@"性别"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:[personalData sharedData].sex];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 2:{
            [cell.textLabel setText:@"学号"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:[NSString stringWithFormat:@"%ld",[personalData sharedData].sno]];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 3:{
            [cell.textLabel setText:@"出生年月"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            //----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *timeString = [formatter stringFromDate:[personalData sharedData].birthday];
            [label1 setText:timeString];
            [label1 setTextColor:[UIColor lightGrayColor]];
            label1.textAlignment = NSTextAlignmentRight;
            [label1 setFont:[UIFont systemFontOfSize:17]];
            [cell.contentView addSubview:label1];
        }
            break;
        case 4:{
            [cell.textLabel setText:@"院系"];
            UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(253, 10 , 98, 40)];
            [label1 setText:[personalData sharedData].dno];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
