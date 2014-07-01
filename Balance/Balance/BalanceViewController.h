//
//  BalanceViewController.h
//  Balance
//
//  Created by Mac X T.Y on 2014/05/21.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

#import <CoreMotion/CoreMotion.h>

@interface BalanceViewController : UIViewController // <UIAccelerometerDelegate>
{
    double accelX, accelY, accelZ; // 加速度
    double speedX, speedY; // 速度
    double positionX, positionY; // 位置
    SystemSoundID soundID; // 効果音
}

@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (strong, nonatomic) IBOutlet UIImageView *flash;

@property (nonatomic, strong) CMMotionManager *motionManager; // モーションマネージャー

- (void)move; // ボールを移動させるメソッド
- (void)bump; // ボールが衝突した時に、フレームを光らせるメソッド

@end