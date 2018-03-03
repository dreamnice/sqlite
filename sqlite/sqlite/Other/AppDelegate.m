//
//  AppDelegate.m
//  sqlite
//
//  Created by 朱力珅 on 2018/1/14.
//  Copyright © 2018年 朱力珅. All rights reserved.
//

#import "AppDelegate.h"
#import "MainController.h"
#import "MenuController.h"
#import "ZLSSqlite.h"
#import "courseItem.h"
#import "studentCourseItem.h"
#import "studentItem.h"
#import "departmentItem.h"
#import "teacherItem.h"

@interface AppDelegate (){
    UINavigationController *mainNavc;
    UINavigationController *menuNavc;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self createTabel];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    MainController *mainVC = [[MainController alloc] init];
    mainNavc = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = mainNavc;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)createTabel{
    if(![[ZLSSqlite defaultZLSSqlite] checkName:@"department_5470"]){
        NSInteger t1 = 100 , t2 = 200 , t3 = 300 , t4 = 400;
        departmentItem *item1 = [[departmentItem alloc] initWithDno:t1 dname:@"计算机学院"];
        departmentItem *item2 = [[departmentItem alloc] initWithDno:t2 dname:@"外国语学院"];
        departmentItem *item3 = [[departmentItem alloc] initWithDno:t3 dname:@"管理学院"];
        departmentItem *item4 = [[departmentItem alloc] initWithDno:t4 dname:@"机电学院"];
        
        [[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item1];
        [[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item2];
        [[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item3];
        [[ZLSSqlite defaultZLSSqlite] insertIntoTableWithitems:item4];
    }
    
    NSInteger t = 0;
    courseItem *item1 = [[courseItem alloc] initWithCno:t cname:nil tno:t credit:t chour:t ctime:nil cplace:nil testTime:nil];
    studentCourseItem *item2 = [[studentCourseItem alloc] initWithSno:t cno:t score:t];
    studentItem *item3 = [[studentItem alloc] initWithSno:t name:nil sex:nil birthday:nil dno:t];
    teacherItem *item4 = [[teacherItem alloc] initWithTno:t name:nil sex:nil birthday:nil  dno:t];
    NSArray <item *>*array = @[item1,item2,item3];
    [[ZLSSqlite defaultZLSSqlite] CreateAllTabel:array];
}


-(void)showMenu{
    MenuController *mainVC = [[MenuController alloc] init];
    menuNavc = [[UINavigationController alloc] initWithRootViewController:mainVC];
    self.window.rootViewController = menuNavc;
    mainNavc = nil;
}

- (void)showMain{
    MainController *vc = [[MainController alloc] init];
    mainNavc = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = mainNavc;
    menuNavc = nil;
}

@end
