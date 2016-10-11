//
//  ViewController.h
//  本地推送
//
//  Created by 杨瑷惠 on 16/8/3.
//  Copyright © 2016年 杨瑷惠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// 设置本地通知
+ (void)registerLocalNotification:(NSInteger)alertTime;
+ (void)cancelLocalNotificationWithKey:(NSString *)key;

@end

