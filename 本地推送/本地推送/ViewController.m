//
//  ViewController.m
//  本地推送
//
//  Created by 杨瑷惠 on 16/8/3.
//  Copyright © 2016年 杨瑷惠. All rights reserved.
//

#import "ViewController.h"

#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 创建一个本地推送
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    //设置10秒之后
//    NSDateFormatter *format = [[NSDateFormatter alloc] init];
//    format.dateFormat = @"HH:mm:ss";
//    NSDate *date = [format dateFromString:@"10:00:00"];
//    if (notification != nil) {
//        // 设置推送时间
//        notification.fireDate = date;
//        // 设置时区
//        notification.timeZone = [NSTimeZone defaultTimeZone];
//        
//        // 设置重复间隔 工作日
//        notification.repeatInterval = NSCalendarUnitWeekday;
//        // 推送声音
//        notification.soundName = UILocalNotificationDefaultSoundName;
//        // 推送内容
//        NSString *str = @"10";
//        notification.alertBody = [NSString stringWithFormat:@"你有%@单据需要审批", str];
//        // 推送震动
////        AudioServicesPlaySystemSound();
//        
//        //显示在icon上的红色圈中的数子
//        notification.applicationIconBadgeNumber = [str integerValue];
//        //设置userinfo 方便在之后需要撤销的时候使用
//        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name"forKey:@"key"];
//        notification.userInfo = info;
//        //添加推送到UIApplication
//        UIApplication *app = [UIApplication sharedApplication];
//        //            调度本地推送通知(调度完毕后,推动通知会在特定时
//        [app scheduleLocalNotification:notification];
//    }
    
    
    
    
//    self.title = @"本地通知";
    UIButton *notBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    notBtn.frame = CGRectMake(20, 100, 320-40, 40);
    [notBtn setBackgroundColor:[UIColor lightGrayColor]];
    [notBtn setTitle:@"打卡通知推送啦" forState:UIControlStateNormal];
    [notBtn addTarget:self action:@selector(notClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:notBtn];

}

- (void)notClick:(id)sender {
    NSLog(@"notBtn:%s",__FUNCTION__);
    
    [ViewController registerLocalNotification:4];// 4秒后
}

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    // 设置触发通知的时间
    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
    NSLog(@"fireDate=%@",fireDate);
    
    notification.fireDate = fireDate;
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
//    notification.repeatInterval = kCFCalendarUnitSecond;
    
    
    
    
    [self methodGet:@"20161001"];
    
    
    // 通知内容
    notification.alertBody =  @"该打卡啦...";
    notification.applicationIconBadgeNumber = 10;
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"打卡通知了" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
                                                                                 categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSCalendarUnitDay;
    } else {
        // 通知重复提示的单位，可以是天、周、月
        notification.repeatInterval = NSDayCalendarUnit;
    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

// 取消某个本地推送通知
+ (void)cancelLocalNotificationWithKey:(NSString *)key {
    // 获取所有本地通知数组
    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
    
    for (UILocalNotification *notification in localNotifications) {
        NSDictionary *userInfo = notification.userInfo;
        if (userInfo) {
            // 根据设置通知参数时指定的key来获取通知参数
            NSString *info = userInfo[key];
            
            // 如果找到需要取消的通知，则取消
            if (info != nil) {
                [[UIApplication sharedApplication] cancelLocalNotification:notification];
                break;
            }
        }
    }
}

+(void)methodGet:(NSString*)str
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{
                             @"d" : str,
                             };
    [manager GET:@"http://www.easybots.cn/api/holiday.php" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"请求成功---%@", responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求失败---%@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
