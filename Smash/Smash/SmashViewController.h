//
//  SmashViewController.h
//  Smash
//
//  Created by 14cm0132 on 2014/05/07.
//  Copyright (c) 2014年 jec.ac.jp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioServices.h>

@interface SmashViewController : UIViewController
{
    SystemSoundID soundID; //効果音
    int score; //スコア
}

- (void)move:(NSTimer *)timer; //タイマーから呼び出される

@end
