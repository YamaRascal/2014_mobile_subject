//
//  ClockViewController.h
//  Clock
//
//  Created by 14cm0132 on 2014/06/10.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVAudioPlayer.h>

#define kAlarmEnabledKey    @"Alarm Enabled"
#define kAlarmHourKey       @"Alarm Hour"

@interface ClockViewController : UIViewController


- (void)driveClock:(NSTimer *)timer;    //タイマーから呼び出される
- (void)setAlarmItems;  //アラームのビュー・アイテムを設定
-(void)saveUserDefaults;


@end
